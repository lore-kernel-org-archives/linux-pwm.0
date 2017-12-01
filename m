From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 3/5] pwm-backlight: add support for PWM delays proprieties.
Date: Fri, 1 Dec 2017 11:56:52 +0100
Message-ID: <CAFqH_53tr9JaSj=tLSoBYM9thDOJz4vvLy8_eddFKKn1ZHtdzw@mail.gmail.com>
References: <20170721104813.5389-1-enric.balletbo@collabora.com>
 <20170721104813.5389-3-enric.balletbo@collabora.com> <0e2d4f9b-0f27-3793-0c27-2a2df5c32cf0@linaro.org>
 <000001d30630$e2a3d160$a7eb7420$@gmail.com> <CAFqH_52odQdYqSZsCYAydQ5vUudZor7gO+Ro3ccVJb6t+e5KhA@mail.gmail.com>
 <20171201105425.bdkusyij5sstka23@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33605 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdLAK4x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 1 Dec 2017 05:56:53 -0500
In-Reply-To: <20171201105425.bdkusyij5sstka23@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

Hi,

2017-12-01 11:54 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> On Fri, 01 Dec 2017, Enric Balletbo Serra wrote:
>> 2017-07-26 19:01 GMT+02:00 Jingoo Han <jingoohan1@gmail.com>:
>> > On Monday, July 24, 2017 11:22 AM, Daniel Thompson wrote:
>> >> On 21/07/17 11:48, Enric Balletbo i Serra wrote:
>> >> > Some panels (i.e. N116BGE-L41), in their power sequence specificati=
ons,
>> >> > request a delay between set the PWM signal and enable the backlight=
 and
>> >> > between clear the PWM signal and disable the backlight. Add support=
 for
>> >> > the new post-pwm-on-delay-ms and pwm-off-delay-ms proprieties to me=
et
>> >> > the timings.
>> >> >
>> >> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com=
>
>> >>
>> >> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>> >
>> > Acked-by: Jingoo Han <jingoohan1@gmail.com>
>> >
>>
>> A lot of time has passed since these patches received the acks but I'm
>> still without seeing the patches in linux-next. There is some action I
>> need to do ? (rebase?). I'd really like to see those to land in next
>> merge window if all is ok.
>
> Looks like you are still missing Acks on some of the patches and have
> questions outstanding.
>
> Best thing to do is rebase and resubmit with all of the Acks you've
> collected applied.
>

Thanks will do that then.

> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
