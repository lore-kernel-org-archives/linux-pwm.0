From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add
 Allwinner sun8i.
Date: Thu, 20 Dec 2018 18:50:09 +0100
Message-ID: <20181220175009.GF9408@ulmo>
References: <20181125161859.GA5277@arx-s1>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBVFM57QAKGQEI34ACMI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20181125161859.GA5277@arx-s1>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> This patch adds Allwinner sun8i pwm binding document.
> 
> Signed-off-by: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..7531d85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: Should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: Physical base address and length of the controller's registers
> +  - interrupts: Should contain interrupt.
> +  - clocks: From common clock binding, handle to the parent clock.
> +  - clock-names: Must contain the clock names described just above.
> +  - pwm-channels: PWM channels of the controller.

Why do you need this? In the cover letter you say:

	"The sun8i R40/T3/V40 PWM has 8 PWM channals ..."

Why does this need to be specified in the DT?

Thierry
--IvGM3kKqwtniy32b--
