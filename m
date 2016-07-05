From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 12/14] regulator: pwm: Retrieve correct voltage
Date: Tue, 5 Jul 2016 16:32:09 +0200
Message-ID: <20160705143209.GZ6247@sirena.org.uk>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-13-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jOWcLJj2EpBZWei/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45098 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbcGEOcn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Jul 2016 10:32:43 -0400
Content-Disposition: inline
In-Reply-To: <1465895602-31008-13-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>


--jOWcLJj2EpBZWei/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 14, 2016 at 11:13:20AM +0200, Boris Brezillon wrote:
> The continuous PWM voltage regulator is caching the voltage value in
> the ->volt_uV field. While most of the time this value should reflect the
> real voltage, sometime it can be sightly different if the PWM device
> rounded the set_duty_cycle request.
> Moreover, this value is not valid until someone has modified the regulator
> output.

Acked-by: Mark Brown <broonie@kernel.org>

--jOWcLJj2EpBZWei/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe8ToAAoJECTWi3JdVIfQxjQH/jyKMWjwuag2+CfZHIEBCHYq
iSXhAfd3aDDUFR0acMpCSWXbx3t+aBjfOdreBplXquaPvgRVSw7esGbT/Uegx2rj
7UghiULKA6GoyMRewACT6ctyq7/LLykWXR3NH8OMdZ2VGNbgc5EteAEYjgf1qJUx
ghVG27uKbUrW8EyQsFOlQbLk0clT4OJg26NRtWGSsdVkHgFUjw0phfX6qsELAJXL
NLYYVs0xJVI6HLBRDDnylKpDOHxGm5w2010NX8sQqPGANJ+mI8DyiybjcEqFRX/3
sc34O7U7/cwqOUNSgWBbpI6A9Oo9j8QQra1wAiTvzPBPCKb8AiVEPPsfmx5KDJc=
=+D3r
-----END PGP SIGNATURE-----

--jOWcLJj2EpBZWei/--
