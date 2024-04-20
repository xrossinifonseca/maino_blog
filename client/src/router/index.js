import { createRouter, createWebHistory } from "vue-router";
import { Home, Layout, Login, MyPosts, Signup } from "../views";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "layout",
      component: Layout,
      children: [
        {
          path: "/",
          name: "home",
          component: Home,
          meta: "Home",
        },
        {
          path: "/login",
          name: "login",
          component: Login,
          meta: "login",
        },
        {
          path: "signup",
          name: "signup",
          component: Signup,
          meta: "signup",
        },
        {
          path: "my-posts",
          name: "my-posts",
          component: MyPosts,
        },
      ],
    },
  ],
});

export default router;

// {
//     path: '/',
//     name: 'layout',
//     meta: {
//       title: 'Admin | Cyberteza'
//     },
//     component: LayoutView,
//     beforeEnter: () => {
//       const store = useAuthAdminStore()
//       if (!store.authenticated) {
//         return { name: 'login' }
//       }
//     },
//     children: [
//       {
//         path: '',
//         name: 'analytics',
//         component: AnalyticsView
//       },
//       {
//         path: 'produtos',
//         name: 'products',
//         component: ProductsViewVue
//       }
//     ]
//   },
//   {
//     path: '/login',
//     name: 'login',
//     component: LoginViewVue,
//     meta: {
//       title: 'login'
//     },
//     beforeEnter: () => {
//       const store = useAuthAdminStore()
//       if (store.authenticated) {
//         return { name: 'layout' }
//       }
//     }
//   }
