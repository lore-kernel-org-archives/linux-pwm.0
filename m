From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 10/14] regulator: pwm: Switch to the atomic PWM API
Date: Tue, 5 Jul 2016 16:30:40 +0200
Message-ID: <20160705143040.GX6247@sirena.org.uk>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-11-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ndWVA4pxvhlNOeHP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45018 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbcGEOb0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Jul 2016 10:31:26 -0400
Content-Disposition: inline
In-Reply-To: <1465895602-31008-11-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>


--ndWVA4pxvhlNOeHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 14, 2016 at 11:13:18AM +0200, Boris Brezillon wrote:

> Use the atomic API wherever appropriate and get rid of pwm_apply_args()
> call (the reference period and polarity are now explicitly set when
> calling pwm_apply_state()).

Acked-by: Mark Brown <broonie@kernel.org>

--ndWVA4pxvhlNOeHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe8SDAAoJECTWi3JdVIfQf0AH/iyVwH4udjUoZ5KiwpYLX8UO
UbdnOJV1X+uL4kXIcxtMV8I/c2pOYwUsHmHFMVTJf/BIHaDASAVn2E5amzgI6jcA
LiDxoUFKg6IS8WUYWqkNalHPfoW0NB0fd62/z9eKXJGpoMWt2BBIh+lHKU0z9xuw
8h46D+J13H23U3qu0MWoYw1S7cPyhtv/wenO5fGGN5eytJV5SA7gyPObinIPl4i/
nxd8iu8IytmD6EdMi68JoTB+xGvby0LHZ8nCQ8xmy41nORUqGqIAoYgFAfz/qOBD
sxxPu3wZP4YUcXUjdivNDNZiMo9VbiF3v+4LS13zfZWEf9bKSj2+jEFGXw4IpLY=
=Qdt8
-----END PGP SIGNATURE-----

--ndWVA4pxvhlNOeHP--
