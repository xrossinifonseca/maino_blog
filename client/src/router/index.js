import { createRouter, createWebHistory } from "vue-router";
import {
  Home,
  Layout,
  Login,
  MyPosts,
  NewPost,
  Post,
  RecoverPassword,
  Signup,
} from "../views";
import { isAuthenticated } from "../auth/index";

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
          path: "post/:id",
          name: "post",
          component: Post,
        },

        {
          path: "",
          name: "private",
          beforeEnter: () => {
            if (!isAuthenticated.value) {
              return { name: "home" };
            }
          },
          children: [
            {
              path: "my-posts",
              name: "my-posts",
              component: MyPosts,
            },
            {
              path: "post/new",
              name: "new",
              component: NewPost,
            },
          ],
        },

        {
          path: "",
          name: "public",
          beforeEnter: () => {
            if (isAuthenticated.value) {
              return { name: "home" };
            }
          },
          children: [
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
              path: "recover-password",
              name: "recover-password",
              component: RecoverPassword,
            },
          ],
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

//   }
