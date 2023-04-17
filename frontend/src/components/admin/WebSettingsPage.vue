<script setup>
import { ref, reactive } from 'vue';
import { QuillEditor } from '@vueup/vue-quill'
import axios from 'axios';
import MazBtn from 'maz-ui/components/MazBtn'
import { useToast } from 'vue-toast-notification';
import { getTerms } from '../../additional/axiosPosts';

const BASE_URL = import.meta.env.VITE_SERVER_BASE_URL
const quillTermsContent = ref('')
const toast = useToast()

const state = reactive({
    previewQuillTermsContent: false,
    sending: false
})

const retrieveTerms = async () => {
    const data = await getTerms()

    quillTermsContent.value = data

    console.log(state.quillTermsContent)
}

retrieveTerms()

const updateTerms = async () => {
    state.sending = true

    await axios.post(BASE_URL + 'updateTerms.php', {
        terms_content: quillTermsContent.value
    })
        .catch(err => {
            toast.open({
                message: 'O eroare a fost întâmpinată în timpul<br> actualizării.',
                duration: 5000,
                type: "error"
            })

            console.error(err)
        })
        .then(({ data }) => {
            console.log(data)

            if (data.hasOwnProperty("be_msg_success")) {
                toast.open({
                    message: 'Termenii și condițiile au fost actualizate cu succes',
                    duration: 3000,
                    type: "success"
                })
            }
            else if (data.hasOwnProperty("be_msg_error")) {
                toast.open({
                    message: data.be_msg_error,
                    duration: 9000,
                    type: "error"
                })
            }
            else {
                toast.open({
                    message: "Eroare necunoscută în timpul actualizării. <b>Deschide consola.</b>",
                    duration: 9000,
                    type: "error"
                })

                console.error(data)
            }
        })
        .finally(() => state.sending = false)
}
</script>

<template>
    <div class="py-[20px] px-[30px]">
        <section id="terms" class="flex flex-col gap-[20px]">
            <h1 class="text-[20px] my-[20px]">Modifică Termenii Și Condițiile</h1>
            <div class="h-fit max-h-[500px] overflow-y-auto">
                <QuillEditor toolbar="full" theme="snow" contentType="html" v-model:content="quillTermsContent" />
            </div>

            <div class="flex justify-between">
                <MazBtn @click="state.previewQuillTermsContent = !state.previewQuillTermsContent">{{
                    state.previewQuillTermsContent ? 'Dezactivează' : 'Activează' }} previzualizarea</MazBtn>
                <MazBtn :loading="state.sending" @click="updateTerms" class="w-[150px]">Actualizează</MazBtn>
            </div>

            <div v-if="state.previewQuillTermsContent">
                <h2 class="text-[20px] my-[20px]">Previzualizează</h2>
                <div v-html="quillTermsContent"
                    class="max-h-[500px] border-[1px] border-slate-700 p-[20px] overflow-y-auto">
                </div>
            </div>
        </section>
    </div>
</template>