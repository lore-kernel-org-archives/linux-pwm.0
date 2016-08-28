From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH v3 3/4] ARM64: dts: meson-gxbb: Add Meson GXBB PWM
 Controller nodes
Date: Sun, 28 Aug 2016 18:29:39 +0200
Message-ID: <CAFBinCDBPgrHsDuPLV=4MTFLZn10DmXM8FR171W9g3SoZUJ9aw@mail.gmail.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com> <1471880193-21879-4-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471880193-21879-4-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Aug 22, 2016 at 5:36 PM, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index e502c24..e3f4d36 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -153,6 +153,27 @@
>                                 status = "disabled";
>                         };
>
> +                       pwm_ab: pwm@8550 {
> +                               compatible = "amlogic,meson-gxbb-pwm";
> +                               reg = <0x0 0x08550 0x0 0x10>;
> +                               #pwm-cells = <3>;
> +                               status = "disabled";
> +                       };
> +
> +                       pwm_cd: pwm@8650 {
> +                               compatible = "amlogic,meson-gxbb-pwm";
> +                               reg = <0x0 0x08650 0x0 0x10>;
> +                               #pwm-cells = <3>;
> +                               status = "disabled";
> +                       };
> +
> +                       pwm_ef: pwm@86c0 {
> +                               compatible = "amlogic,meson-gxbb-pwm";
> +                               reg = <0x0 0x086c0 0x0 0x10>;
> +                               #pwm-cells = <3>;
> +                               status = "disabled";
> +                       };
I have successfully tested pwm_e on my meson-gxbb-vega-s95-meta clone
(see [0] for the corresponding patches), thus:
Tested-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

[0] https://github.com/xdarklight/linux/tree/meson-gxbb-integration-4.8-20160828
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
