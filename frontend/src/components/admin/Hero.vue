<script setup>
  import Navbar from "@/components/admin/NavBar.vue"
  import { useAccountStore } from "@/stores/account"

  const account = useAccountStore()
</script>

<template>
  <Navbar />
  <div class="bg-[#000]">
    <div class="mx-auto container pb-[213px]">
      <div
        class="flex justify-between items-center py-[44px] border-b border-[#FFFFFF1A]"
      >
        <div class="flex items-center gap-[28px]">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="60"
            height="60"
            viewBox="0 0 24 24"
            style="fill: rgba(255, 255, 255, 1); transform: ; msfilter: "
          >
            <path
              d="M7.5 6.5C7.5 8.981 9.519 11 12 11s4.5-2.019 4.5-4.5S14.481 2 12 2 7.5 4.019 7.5 6.5zM20 21h1v-1c0-3.859-3.141-7-7-7h-4c-3.86 0-7 3.141-7 7v1h17z"
            ></path>
          </svg>
          <div>
            <p class="text-[#FFFFFF80] text-[16px]">Bine ai revenit</p>
            <h3 class="text-white text-[32px] font-semibold">
              {{ account.getUsername() }}
            </h3>
          </div>
        </div>
        <button
          @click="account.logOut()"
          class="bg-white text-black px-[42px] py-[11px] rounded-[30px]"
        >
          Sign Out
        </button>
      </div>
    </div>
  </div>
  <div class="mx-auto container mt-[-220px] flex justify-between items-center">
    <h2 class="text-white font-semibold text-[32px] my-[40px]">
      {{ getHeroTitle() }}
    </h2>
    <button v-if="this.$route.params.section == 'evenimente'" data-modal-target="createEventModal" data-modal-toggle="createEventModal" class="bg-[#fff] text-black rounded-full px-4 py-3 flex gap-2 items-center">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;"><path d="M19 11h-6V5h-2v6H5v2h6v6h2v-6h6z"></path></svg>
      Creeaza eveniment
    </button>
  </div>
</template>

<script>
  export default {
    methods: {
      getHeroTitle() {
        let heroTitle = "Dashboard"

        switch (this.$route.params.section) {
          case "utilizatori":
            heroTitle += " / Utilizatori"
            break

          case "evenimente":
            heroTitle += " / Evenimente"
            break
        }

        switch (this.$route.name) {
          case "edituser":
            heroTitle += " / Editeaza"
            break
        }

        return heroTitle
      },
    },
  }
</script>
