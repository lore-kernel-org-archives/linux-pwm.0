From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Subject: Re: [PATCH v2 4/4] dts: sunxi: A64: Add PWM controllers
Date: Mon, 19 Mar 2018 01:04:29 +0100
Message-ID: <8200788.OcfDqQcPbJ@pebbles>
References: <20180318232847.14278-1-andre.przywara@arm.com> <20180318232847.14278-5-andre.przywara@arm.com>
Reply-To: stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4368031.duILcS1gDj";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-sunxi+bncBDIYL7P2SAMRBGH5XPKQKGQEILWX7JI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180318232847.14278-5-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, andre.przywara-5wv7dgnIgG8@public.gmane.org
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

--nextPart4368031.duILcS1gDj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Montag, 19. M=C3=A4rz 2018 00:28:47 CET Andre Przywara wrote:
> The Allwinner A64 SoC features two PWM controllers, which are fully
> compatible to the one used in the A13 and H3 chips.
> Add the respective device nodes (one for the "normal" PWM, the other for
> the one in the CPUS domain) and the pin their output is connected to.

"Add the nodes for the devices (...) and the pins their outputs are connect=
ed=20
to."

> On the A64 the "normal" PWM is muxed together with one of the MDIO pins
> used to communicate with the Ethernet PHY, so it won't be usable on many
> boards. But the Pinebook laptop uses this pin for controlling the LCD
> backlight.
> The CPUS PWM pin however is routed to the "RPi2" header, at the same
> location as the PWM pin on the RaspberryPi.

The last sentence is misssing a reference to the Pine64.
=20
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 28
> +++++++++++++++++++++++++++ 1 file changed, 28 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> d783d164b9c3..fda1783b1c86 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -321,6 +321,11 @@
<...>

Kind regards,

Stefan

--=20
Stefan Br=C3=BCns  /  Bergstra=C3=9Fe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--nextPart4368031.duILcS1gDj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWq7+jQAKCRBvf0o9jP6q
U0lmAJ4qDQfxMi9FnRnON1VRHm7nQW8WswCfQEubRlcRvzxUzzlLhuq5GsYwaVU=
=jNEZ
-----END PGP SIGNATURE-----

--nextPart4368031.duILcS1gDj--
