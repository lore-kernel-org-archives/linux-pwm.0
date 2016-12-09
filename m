From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 6/7] IIO: add STM32 timer trigger driver
Date: Fri, 9 Dec 2016 08:59:15 +0000
Message-ID: <20161209085915.GD3625@dell.home>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-7-git-send-email-benjamin.gaignard@st.com>
 <20161206131635.GJ25385@dell.home>
 <CA+M3ks6fxCucmaY0OgpMb_opA=YLrowijJ0YQ+imeprhWg6N_w@mail.gmail.com>
 <20161207105002.GA3625@dell.home>
 <CA+M3ks4VbV6z6t7aORKGmduZfFF+Ls7Sq8umWRFyo3sn8WZt7g@mail.gmail.com>
 <5dcec09c-8b4b-4cc2-ce3f-fde86366ec05@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5dcec09c-8b4b-4cc2-ce3f-fde86366ec05-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>, Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, 07 Dec 2016, Daniel Thompson wrote:

> On 07/12/16 11:00, Benjamin Gaignard wrote:
> > 2016-12-07 11:50 GMT+01:00 Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> > > On Tue, 06 Dec 2016, Benjamin Gaignard wrote:
> > > 
> > > > [snip]
> > > > > > +
> > > > > > +static const char * const triggers0[] = {
> > > > > > +     TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const char * const triggers1[] = {
> > > > > > +     TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const char * const triggers2[] = {
> > > > > > +     TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const char * const triggers3[] = {
> > > > > > +     TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const char * const triggers4[] = {
> > > > > > +     TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const char * const triggers5[] = {
> > > > > > +     TIM6_TRGO, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const char * const triggers6[] = {
> > > > > > +     TIM7_TRGO, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const char * const triggers7[] = {
> > > > > > +     TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const char * const triggers8[] = {
> > > > > > +     TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const char * const triggers9[] = {
> > > > > > +     TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const void *triggers_table[] = {
> > > > > > +     triggers0,
> > > > > > +     triggers1,
> > > > > > +     triggers2,
> > > > > > +     triggers3,
> > > > > > +     triggers4,
> > > > > > +     triggers5,
> > > > > > +     triggers6,
> > > > > > +     triggers7,
> > > > > > +     triggers8,
> > > > > > +     triggers9,
> > > > > > +};
> > > > > 
> > > > > What about:
> > > > > 
> > > > > static const char * const triggers[][] = {
> > > > >         { TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL },
> > > > >         { TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL },
> > > > >         { TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL },
> > > > >         { TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL },
> > > > >         { TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL },
> > > > >         { TIM6_TRGO, NULL },
> > > > >         { TIM7_TRGO, NULL },
> > > > >         { TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL },
> > > > >         { TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL },
> > > > >         { TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL }
> > > > > };
> > > > 
> > > > I can't because the second dimension of the array isn't fix.
> > > > I could have between 2 and 6 elements per row... to create a dual dimension
> > > > array I would have to add NULL entries like that:
> > > > 
> > > > #define MAX_TRIGGERS 6
> > > > 
> > > > static const void *triggers_table[][MAX_TRIGGERS] = {
> > > > { TIM1_TRGO, TIM1_CH1, TIM1_CH2, TIM1_CH3, TIM1_CH4, NULL,},
> > > > { TIM2_TRGO, TIM2_CH1, TIM2_CH2, TIM2_CH3, TIM2_CH4, NULL,},
> > > > { TIM3_TRGO, TIM3_CH1, TIM3_CH2, TIM3_CH3, TIM3_CH4, NULL,},
> > > > { TIM4_TRGO, TIM4_CH1, TIM4_CH2, TIM4_CH3, TIM4_CH4, NULL,},
> > > > { TIM5_TRGO, TIM5_CH1, TIM5_CH2, TIM5_CH3, TIM5_CH4, NULL,},
> > > > { TIM6_TRGO, NULL,     NULL,     NULL,     NULL,     NULL,},
> > > > { TIM7_TRGO, NULL,     NULL,     NULL,     NULL,     NULL,},
> > > > { TIM8_TRGO, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4, NULL,},
> > > > { TIM9_TRGO, TIM9_CH1, TIM9_CH2, NULL,     NULL,     NULL,},
> > > > { TIM12_TRGO, TIM12_CH1, TIM12_CH2, NULL,  NULL,     NULL,},
> > > > };
> > > 
> > > It was just an idea, not a tested implementation.
> > > 
> > > I don't understand why you have to pad with NULLs, but either way, it
> > > looks much better than before and saves lots of lines of code.
> > 
> > I have tested it this morning and it works fine so I will include it in v5.
> > I use NULL as limit when iterate in the table and for table padding too.
> 
> If the initializer is shorter than the array then the array will be
> implicitly zero/NULL padded. I don't think there is any need to type out all
> the NULLs (not even at -Wall).

+1.  My point precisely.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
