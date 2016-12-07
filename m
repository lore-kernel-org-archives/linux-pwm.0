From: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 6/7] IIO: add STM32 timer trigger driver
Date: Wed, 7 Dec 2016 12:00:21 +0100
Message-ID: <CA+M3ks4VbV6z6t7aORKGmduZfFF+Ls7Sq8umWRFyo3sn8WZt7g@mail.gmail.com>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-7-git-send-email-benjamin.gaignard@st.com>
 <20161206131635.GJ25385@dell.home> <CA+M3ks6fxCucmaY0OgpMb_opA=YLrowijJ0YQ+imeprhWg6N_w@mail.gmail.com>
 <20161207105002.GA3625@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161207105002.GA3625-Re9dqnLqz4GzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>, Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

2016-12-07 11:50 GMT+01:00 Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> On Tue, 06 Dec 2016, Benjamin Gaignard wrote:
>
>> [snip]
>> >> +
>> >> +static const char * const triggers0[] =3D {
>> >> +     TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL,
>> >> +};
>> >> +
>> >> +static const char * const triggers1[] =3D {
>> >> +     TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL,
>> >> +};
>> >> +
>> >> +static const char * const triggers2[] =3D {
>> >> +     TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL,
>> >> +};
>> >> +
>> >> +static const char * const triggers3[] =3D {
>> >> +     TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL,
>> >> +};
>> >> +
>> >> +static const char * const triggers4[] =3D {
>> >> +     TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL,
>> >> +};
>> >> +
>> >> +static const char * const triggers5[] =3D {
>> >> +     TIM6_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const char * const triggers6[] =3D {
>> >> +     TIM7_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const char * const triggers7[] =3D {
>> >> +     TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL,
>> >> +};
>> >> +
>> >> +static const char * const triggers8[] =3D {
>> >> +     TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL,
>> >> +};
>> >> +
>> >> +static const char * const triggers9[] =3D {
>> >> +     TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL,
>> >> +};
>> >> +
>> >> +static const void *triggers_table[] =3D {
>> >> +     triggers0,
>> >> +     triggers1,
>> >> +     triggers2,
>> >> +     triggers3,
>> >> +     triggers4,
>> >> +     triggers5,
>> >> +     triggers6,
>> >> +     triggers7,
>> >> +     triggers8,
>> >> +     triggers9,
>> >> +};
>> >
>> > What about:
>> >
>> > static const char * const triggers[][] =3D {
>> >         { TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL },
>> >         { TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL },
>> >         { TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL },
>> >         { TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL },
>> >         { TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL },
>> >         { TIM6_TRGO, NULL },
>> >         { TIM7_TRGO, NULL },
>> >         { TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL },
>> >         { TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL },
>> >         { TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL }
>> > };
>>
>> I can't because the second dimension of the array isn't fix.
>> I could have between 2 and 6 elements per row... to create a dual dimens=
ion
>> array I would have to add NULL entries like that:
>>
>> #define MAX_TRIGGERS 6
>>
>> static const void *triggers_table[][MAX_TRIGGERS] =3D {
>> { TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL,},
>> { TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL,},
>> { TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL,},
>> { TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL,},
>> { TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL,},
>> { TIM6_TRGO, NULL,     NULL,     NULL,     NULL,     NULL,},
>> { TIM7_TRGO, NULL,     NULL,     NULL,     NULL,     NULL,},
>> { TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL,},
>> { TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL,     NULL,     NULL,},
>> { TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL,  NULL,     NULL,},
>> };
>
> It was just an idea, not a tested implementation.
>
> I don't understand why you have to pad with NULLs, but either way, it
> looks much better than before and saves lots of lines of code.

I have tested it this morning and it works fine so I will include it in v5.
I use NULL as limit when iterate in the table and for table padding too.

>
>> >> +static const char * const valids0[] =3D {
>> >> +     TIM5_TRGO, TIM2_TRGO, TIM4_TRGO, TIM3_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const char * const valids1[] =3D {
>> >> +     TIM1_TRGO, TIM8_TRGO, TIM3_TRGO, TIM4_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const char * const valids2[] =3D {
>> >> +     TIM1_TRGO, TIM8_TRGO, TIM5_TRGO, TIM4_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const char * const valids3[] =3D {
>> >> +     TIM1_TRGO, TIM2_TRGO, TIM3_TRGO, TIM8_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const char *const valids4[] =3D {
>> >> +     TIM2_TRGO, TIM3_TRGO, TIM4_TRGO, TIM8_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const char * const valids7[] =3D {
>> >> +     TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const char * const valids8[] =3D {
>> >> +     TIM2_TRGO, TIM3_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const char * const valids9[] =3D {
>> >> +     TIM4_TRGO, TIM5_TRGO, NULL,
>> >> +};
>> >> +
>> >> +static const void *valids_table[] =3D {
>> >> +     valids0,
>> >> +     valids1,
>> >> +     valids2,
>> >> +     valids3,
>> >> +     valids4,
>> >> +     NULL,
>> >> +     NULL,
>> >> +     valids7,
>> >> +     valids8,
>> >> +     valids9,
>> >> +};
>> >
>> > Same here.
>> >
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
