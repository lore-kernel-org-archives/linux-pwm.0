From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 12/14] regulator: pwm: Retrieve correct voltage
Date: Sat, 9 Jul 2016 11:47:18 +0200
Message-ID: <20160709094718.GB6247@sirena.org.uk>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-13-git-send-email-boris.brezillon@free-electrons.com>
 <20160708154302.GC1151@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="88Sy+k7s/DRE8Hui"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59988 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbcGIJsK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 9 Jul 2016 05:48:10 -0400
Content-Disposition: inline
In-Reply-To: <20160708154302.GC1151@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidi>


--88Sy+k7s/DRE8Hui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 08, 2016 at 05:43:02PM +0200, Thierry Reding wrote:

> Mark, do you want me to provide a stable branch with the PWM regulator
> patches and resolve that conflict in your tree? Or would you rather take
> the whole set based on a stable branch from the PWM tree? Or maybe yet
> another possibility would be to base the PWM tree on a stable branch
> from the regulator tree containing the above commit.

Probably easiest to use this signed tag and resolve it in your tree:

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/pwm-modernization

for you to fetch changes up to c2588393e6315ab68207323d37d2a73713d6bc81:

  regulator: pwm: Fix regulator ramp delay for continuous mode (2016-07-07 11:45:06 +0200)

----------------------------------------------------------------
regulator: Provide a branch for moderninzation of the PWM code

There's a new, improved PWM API which allows a lot of improvements in
the PWM regulator driver.  Since the bulk of the changes are in the PWM
API this is being managed in the PWM tree, merge pending regulator API
changes to allow this to be resolved more easily.

----------------------------------------------------------------
Alexandre Courbot (1):
      regulator: pwm: Support for enable GPIO

Boris Brezillon (1):
      regulator: pwm: Drop unneeded pwm_enable() call

Douglas Anderson (1):
      regulator: pwm: Fix regulator ramp delay for continuous mode

 .../bindings/regulator/pwm-regulator.txt           |  7 +++-
 drivers/regulator/pwm-regulator.c                  | 40 ++++++++++++++++++----
 2 files changed, 39 insertions(+), 8 deletions(-)

--88Sy+k7s/DRE8Hui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXgMglAAoJECTWi3JdVIfQ70EH/1BQ26zfpvSbiE8Jd94IDj/c
OU7P26dJh5lyCFSWIf7jlC8qQ4zNPzwzaw9/mBgkJYv4/kgX57izRhMmBgNhsV0a
IKh/bfwh+a1nvthZXEwTpblQJ2wbE4xiAMRGCa+VUm8RJU5FL7xa9Tedm9+GAJpK
O6SzeDczwSFZ7txrsOHUsbU1uKaYosR4gjffK2VoxzIXqK3ReWPqsyvs6VaEhL6a
p2+M2seMC8TR+0SeMsB2Co9pUichUok904zOhyEeBfhY/4gvzAxhAo9X/Pj2YcSe
HSQXvXf5Xr+GIIAOq4mkhH5uikdjGje4UH5sDs/6ioPk7RU4eAQX3z3W6EUig54=
=LsdW
-----END PGP SIGNATURE-----

--88Sy+k7s/DRE8Hui--
