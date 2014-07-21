From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 00/11] pwm: Introduce ST's PWM driver
Date: Mon, 21 Jul 2014 13:39:50 +0100
Message-ID: <20140721123950.GY30888@lee--X1>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:51269 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbaGUMj5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jul 2014 08:39:57 -0400
Received: by mail-ig0-f170.google.com with SMTP id h3so3002252igd.3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Jul 2014 05:39:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

Hi Thierry,

Did you find some time to look at this set?

> I'm pretty sure all of your review comments have been tended to
> now.  Some have been fixed-up by myself and re-rolled into the
> original set.  The larger changes have been fixed as subsequent
> patches for ease of review and history tracking on the internal
> kernel.
>=20
> Kind regards,
> Lee
>=20
> Ajit Pal Singh (4):
>   pwm: st: Fix PWM prescaler handling
>   pwm: sti: Ensure same period values for all channels
>   pwm: sti: Sync between enable/disable calls
>   pwm: sti: Remove PWM period table
>=20
> Lee Jones (7):
>   ARM: stih407: Add DT nodes for for PWM
>   ARM: stih416: Add Pinctrl settings for PWM
>   ARM: stih416: Add DT nodes for PWM
>   ARM: stih416-b2020e: Enable PWM on the B2020 Rev-E
>   ARM: multi_v7_defconfig: Enable ST's PWM driver
>   pwm: sti: Add new driver for ST's PWM IP
>   pwm: sti: Supply Device Tree binding documentation for ST's PWM IP
>=20
>  Documentation/devicetree/bindings/pwm/pwm-st.txt |  41 +++
>  arch/arm/boot/dts/stih407.dtsi                   |  28 ++
>  arch/arm/boot/dts/stih416-b2020e.dts             |  10 +
>  arch/arm/boot/dts/stih416-pinctrl.dtsi           |  50 +++
>  arch/arm/boot/dts/stih416.dtsi                   |  44 ++-
>  arch/arm/configs/multi_v7_defconfig              |   1 +
>  drivers/pwm/Kconfig                              |  10 +
>  drivers/pwm/Makefile                             |   1 +
>  drivers/pwm/pwm-sti.c                            | 418 +++++++++++++=
++++++++++
>  9 files changed, 602 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-st.txt
>  create mode 100644 drivers/pwm/pwm-sti.c
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
