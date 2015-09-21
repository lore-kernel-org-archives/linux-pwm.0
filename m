From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 2/5] Documentation: bindings: document the Berlin PWM
 driver
Date: Mon, 21 Sep 2015 10:14:39 +0200
Message-ID: <20150921081439.GD19865@ulmo.nvidia.com>
References: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com>
 <1442484788-15482-3-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33467 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbbIUIOn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2015 04:14:43 -0400
Content-Disposition: inline
In-Reply-To: <1442484788-15482-3-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2015 at 12:13:05PM +0200, Antoine Tenart wrote:
> Following the addition of a Berlin PWM driver, this patch adds the
> corresponding documentation.
>=20
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-berlin.txt | 19 ++++++++++++++=
+++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt

That's the wrong way around. You define the binding, get concensus that
it's okay and then implement the binding in the driver. Of course you'd
always provide both the binding and an implementation in the same patch
series for convenience, but that doesn't change the logical ordering.

> diff --git a/Documentation/devicetree/bindings/pwm/pwm-berlin.txt b/Docum=
entation/devicetree/bindings/pwm/pwm-berlin.txt
> new file mode 100644
> index 000000000000..8f9bc11f8c4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
> @@ -0,0 +1,19 @@
> +Berlin PWM controller
> +
> +PWM IP found in Marvell Berlin SoCs.

This isn't a proper sentence and doesn't add much useful information. If
you want to say anything here, provide details about the PWM controller.

> +
> +Required properties:
> +- compatible: should be "marvell,berlin-pwm"
> +- reg: physical base address and length of the controller's registers
> +- clocks: phandle to the input clock

You should think about adding a clock-names property here as well.

Thierry

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV/7xvAAoJEN0jrNd/PrOhdfIP/2eq+TmwGHmr3ElHvA1LaKPf
LM8F8yNTtFQKTHAdOPu41aome1/Nicjf6frtb03D5o7x7C5rdSr8MTjawVrz2KE6
wU8uN3ojFX2w1R+dVkk/VC2Cw0l/KEyGfYN9NaUZwu2ZfR4vIbRTbC+cyHVWd1ok
MuLhJeF7NVNQhyPNhQSC5YXOIcMmzu8ig8QYBcDXwJZZO+mvXjwKeIpfzacXzw5W
oMQYmrYUMOmQXY04VAvoqy/OERKTyknnPfmxDmWOxt6gRzDvX3xPtaZi1oLfy7Lu
VJ1Q0+nvXIAJtotrJ7cxVp9d/5EZBcvSQnE8j8p1yZHXwT2MOhR3b0fNG5azj5Mu
IbpY9CzYEqGXajtSdRrwnnR9ZqwFm/uDltS+pBiSyzZlmDupT7zb1KZysfqO0TfL
8MWwy6hHmDCaQr6OZTUzZoWzym3X+aY6DIObWMENlalJiv3nLEpXiZeK7kK1cJ6o
TNBz8SH7y6VDPnOvPinC50K3qim+qJew+BBp0cf9Gh7VyoThEUDjLZdUXuK2T7Re
Pccu3VhOggRStQL6qD4k/A/9qg2k8rs1W7RTsVdMxKEWWCcxAwpCCzPrPiT4Wsy1
/j0zNntziyqf4lBENoOWVZTITviNBhWcfkc2sq2MQgGi+0izOQC1dlfnizb8kY8g
+MrXvv2tCxovDVmGPEfa
=1D+D
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
