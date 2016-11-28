From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/7] add bindings for stm32 IIO timer drivers
Date: Mon, 28 Nov 2016 15:44:44 -0600
Message-ID: <20161128214444.wyek4zjyy2sbynzh@rob-hp-laptop>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
 <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
 <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
 <20161122171820.GL10134@dell.home>
 <CA+M3ks7MgnUJoDoNG157+MbdhgbqwzRmhPcD-uQKC7_DJVAK6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+M3ks7MgnUJoDoNG157+MbdhgbqwzRmhPcD-uQKC7_DJVAK6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>, Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Nov 23, 2016 at 09:17:58AM +0100, Benjamin Gaignard wrote:
> If it is ok for you I will add "id" parameter in mfd driver and
> forward it to the sub-devices drivers
> to be able to distinguish the hardware blocks

Please don't top post.

No, it's not okay. If the counter sizes are different, then have a 
property for the counter size. Describe how they are different without 
numbering them. If you can't describe the differences, then it shouldn't 
matter which ones the OS picks to use.

> 2016-11-22 18:18 GMT+01:00 Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> > On Tue, 22 Nov 2016, Benjamin Gaignard wrote:
> >
> >> [snip]
> >> >> +     "st,stm32-iio-timer5"
> >> >> +     "st,stm32-iio-timer6"
> >> >> +     "st,stm32-iio-timer7"
> >> >> +     "st,stm32-iio-timer8"
> >> >> +     "st,stm32-iio-timer9"
> >> >> +     "st,stm32-iio-timer10"
> >> >> +     "st,stm32-iio-timer11"
> >> >> +     "st,stm32-iio-timer12"
> >> >> +     "st,stm32-iio-timer13"
> >> >> +     "st,stm32-iio-timer14"

I doubt the h/w manual calls these "IIO timers".

> >> >
> >> > We can't do this. This is a binding for a driver, not for the hardware.
> >> >
> >>
> >> Unfortunately each instance for the hardware IP have little
> >> differences like which triggers they could accept or size of the
> >> counter register,
> >> and I doesn't have value inside the hardware to distinguish them so
> >> the only way I found is to use compatible.
> >
> > Can't you represent these as properties?
> >
> > --
> > Lee Jones
> > Linaro STMicroelectronics Landing Team Lead
> > Linaro.org │ Open source software for ARM SoCs
> > Follow Linaro: Facebook | Twitter | Blog
> 
> 
> 
> -- 
> Benjamin Gaignard
> 
> Graphic Study Group
> 
> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro: Facebook | Twitter | Blog
