From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH 3/4] doc: dt: pwm: add binding for ChromeOS EC PWM
Date: Sat, 28 May 2016 22:00:45 -0700
Message-ID: <CAMHSBOWSJbcsuojctqOY+8d2Bg8Txtxd-5wFrM0LwJQt7=YRQQ@mail.gmail.com>
References: <1464399556-17222-1-git-send-email-briannorris@chromium.org> <1464399556-17222-4-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37204 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbcE2FBG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 29 May 2016 01:01:06 -0400
Received: by mail-wm0-f41.google.com with SMTP id z87so34921670wmh.0
        for <linux-pwm@vger.kernel.org>; Sat, 28 May 2016 22:01:05 -0700 (PDT)
In-Reply-To: <1464399556-17222-4-git-send-email-briannorris@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, Linux Kernel <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

Instead of using device tree, assuming you have firmware control,
another way could be to add a firmware feature:
for instance, there is one EC_FEATURE_PWM_FAN, the fan PWM, one for
the keyboard lightning as well. (see num ec_feature_code)
By adding one more, you let cros_ec_dev load the platform driver for
you, it works even if the machine does not use device tree.

Gwendal.

On Fri, May 27, 2016 at 6:39 PM, Brian Norris <briannorris@chromium.org> wrote:
> The ChromeOS Embedded Controller can support controlling its attached
> PWMs via its host-command interface. The number of supported PWMs varies
> on a per-board basis, so we define a "google,max-pwms" property to
> handle this. And because the EC only allows specifying the duty cycle
> and not the period, we don't specify the period via pwm-cells, and
> instead have only support 1 cell -- to specify the index.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  .../devicetree/bindings/pwm/google,cros-ec-pwm.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>
> diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> new file mode 100644
> index 000000000000..f1c9540fc23f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> @@ -0,0 +1,25 @@
> +* PWM controlled by ChromeOS EC
> +
> +Google's ChromeOS EC PWM is a simple PWM attached to the Embedded Controller
> +(EC) and controlled via a host-command interface.
> +
> +An EC PWM node should be only found as a sub-node of the EC node (see
> +Documentation/devicetree/bindings/mfd/cros-ec.txt).
> +
> +Required properties:
> +- compatible: Must contain "google,cros-ec-pwm"
> +- #pwm-cells: Should be 1. The cell specifies the PWM index.
> +- google,max-pwms: Specifies the number of PWMs supported by the EC.
> +
> +Example:
> +       cros-ec@0 {
> +               compatible = "google,cros-ec-spi";
> +
> +               ...
> +
> +               cros_ec_pwm: ec-pwm {
> +                       compatible = "google,cros-ec-pwm";
> +                       #pwm-cells = <1>;
> +                       google,max-pwms = <4>;
> +               };
> +       };
> --
> 2.8.0.rc3.226.g39d4020
>
