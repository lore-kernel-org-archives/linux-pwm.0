From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 14/15] regulator: pwm: implement ->enable(),
 ->disable() and ->is_enabled methods
Date: Tue, 14 Jul 2015 11:50:19 +0100
Message-ID: <20150714105019.GR11162@sirena.org.uk>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-15-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+k3B0vOyg/ewl1oH"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51211 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbGNKun (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jul 2015 06:50:43 -0400
Content-Disposition: inline
In-Reply-To: <1435738921-25027-15-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>


--+k3B0vOyg/ewl1oH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2015 at 10:22:00AM +0200, Boris Brezillon wrote:
> Implement the ->enable(), ->disable() and ->is_enabled methods and remove
> the PWM call in ->set_voltage_sel().

This doesn't apply, please check and resend.

--+k3B0vOyg/ewl1oH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpOlrAAoJECTWi3JdVIfQDTMH/AtQ50vnAugEewxCHd4ABmx6
AWC8HTnnr+NYfQRCNdLLEgrv8TP2Q7uBFJAR92gnzBnvQOHtXLSbK6VRYtN0Libk
DYqnJ/pCSzBSJW6goi7uKc6LjVclpjLdO9PGY7ZL1YIt3vH5eJyenvxQMnnjMiNQ
hoPkN7o9tWWDpMJU5Qg/1azA99i98WhTH31VAg79UmzNLrvXmKOxeo9q/hGo1Wve
48EfVl+lLyX7b7lEXPeBk3EXGzLFNBHeTld3bl4RNu/ME6y1Qv7lo3FVOPhiOAbm
PQ7veL5IqSTgixX/zbc5os0y0XSeLP3hG5FZGAVVZQg3kEQjvScN1hSEzCvExms=
=fS+L
-----END PGP SIGNATURE-----

--+k3B0vOyg/ewl1oH--
