From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 05/12] docs: dt: fix references to ap806-system-controller.txt
Date: Tue, 17 Mar 2020 14:50:32 +0100
Message-ID: <CAMpxmJUPA2qDwDu-LUh-RtXt66NhQUdjnPOCSaaBZ9xEm0C5LQ@mail.gmail.com>
References: <cover.1584450500.git.mchehab+huawei@kernel.org> <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52112 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgCQNuq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 09:50:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so21534346wme.1
        for <linux-pwm@vger.kernel.org>; Tue, 17 Mar 2020 06:50:44 -0700 (PDT)
In-Reply-To: <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Ben Peled <bpeled@marvell.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>

wt., 17 mar 2020 o 14:10 Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> napisa=C5=82(a):
>
> ap806-system-controller.txt was renamed to ap80x-system-controller.txt.
>
> Update its references accordingly.
>
> Fixes: 2537831bbc19 ("dt-bindings: ap80x: replace AP806 with AP80x")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.txt        | 2 +-
>  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Docu=
mentation/devicetree/bindings/gpio/gpio-mvebu.txt
> index 2e097b57f170..0fc6700ed800 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> @@ -14,7 +14,7 @@ Required properties:
>
>      "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
>      SoCs (either from AP or CP), see
> -    Documentation/devicetree/bindings/arm/marvell/ap806-system-controlle=
r.txt
> +    Documentation/devicetree/bindings/arm/marvell/ap80x-system-controlle=
r.txt
>      for specific details about the offset property.
>
>  - reg: Address and length of the register set for the device. Only one
> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt=
 b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> index f3b441100890..b0bee7e42038 100644
> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> @@ -12,7 +12,7 @@ Required properties:
>
>  Note: these bindings are deprecated for AP806/CP110 and should instead
>  follow the rules described in:
> -Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.tx=
t
> +Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.tx=
t
>  Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.tx=
t
>
>  - reg: Device's register space.
> --
> 2.24.1
>

For GPIO:

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
