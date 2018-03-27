From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/4] drivers: pwm: sun4i: Improve support
 for A64 SoCs
Date: Wed, 28 Mar 2018 01:14:44 +0200
Message-ID: <20180327231443.GB4097@mithrandir>
References: <20180318232847.14278-1-andre.przywara@arm.com>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBZ5A5PKQKGQE3OL5QPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180318232847.14278-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Sun, Mar 18, 2018 at 11:28:43PM +0000, Andre Przywara wrote:
> A rework addressing the comments. I dropped the H6 and the reset support
> for now, to simplify merging this series.
> 
> This series adds PWM support for new Allwinner SoCs. Actually the A64 PWM 
> is fully compatible with the A13 and H3 PWM IP, so the driver does not
> need any additional code. But I use this opportunity to provide some
> cleanup.
> Patch 1 removes a no longer used parameter from our per-SoC data structure,
> to simplify patch 2, which groups SoCs with a compatible PWM controller.
> Patch 3 adds the new compatible strings to the binding documentation
> (and just there, we expect to use "allwinner,sun5i-a13-pwm" as a fallback
> compatible string).
> The final patch 4 adds the respective PWM nodes to the A64 .dtsi.
> This eventually does not enable the PWM on any new board at the moment, as
> the PWM pins are either not usable (muxed with Ethernet) or exposed on
> a header pin not dedicated to PWM. But the Pinebook (and Teres I) should be
> able to use the PWM for the LCD backlights, plus users can enable the
> R_PWM on their Pine64 boards, if they like.
> 
> Tested by manually enabling r_pwm on a Pine64-LTS.
> 
> Cheers,
> Andre.
> 
> Andre Przywara (4):
>   pwm: sun4i: drop unused .has_rdy member
>   pwm: sun4i: simplify controller mapping
>   dt-bindings: pwm: sunxi: add new compatible strings
>   dts: sunxi: A64: Add PWM controllers
> 
>  .../devicetree/bindings/pwm/pwm-sun4i.txt          |  2 ++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 28 +++++++++++++++++++
>  drivers/pwm/pwm-sun4i.c                            | 32 ++++++----------------
>  3 files changed, 38 insertions(+), 24 deletions(-)

Applied patches 1-3, thanks.

Thierry
--gatW/ieO32f1wygP--
