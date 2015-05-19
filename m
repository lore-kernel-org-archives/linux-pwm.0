From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] backlight: pwm_bl: Simplify usage of devm_gpiod_get_optional
Date: Tue, 19 May 2015 17:18:36 +0800
Message-ID: <CAFRkauDznzcq6yVqQdDrNeaKu666Q_3M+LO1ZNV0DLzCjxOh4w@mail.gmail.com>
References: <1431785290.6638.1.camel@ingics.com>
	<20150519075908.GA23505@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33752 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbbESJSh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 19 May 2015 05:18:37 -0400
Received: by lagr1 with SMTP id r1so13771624lag.0
        for <linux-pwm@vger.kernel.org>; Tue, 19 May 2015 02:18:36 -0700 (PDT)
In-Reply-To: <20150519075908.GA23505@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>

2015-05-19 15:59 GMT+08:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengu=
tronix.de>:
> Hello,
>
> On Sat, May 16, 2015 at 10:08:10PM +0800, Axel Lin wrote:
>> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functio=
ns),
>> the gpiod_get* functions take an additional parameter that allows to
>> specify direction and initial value for output.
>> Simplify the usage of devm_gpiod_get_optional accordingly.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> as I just sent the same patch:
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> @Axel: Do you have some more patches of this type in the queue? I
No, I don't have other patches of this type in the queue.

Regards,
Axel
