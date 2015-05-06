From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/8] pwm: core: Add support to remove
 registered consumer lookup tables
Date: Wed, 6 May 2015 14:21:04 +0200
Message-ID: <20150506122103.GC9421@ulmo>
References: <1430316005-16480-3-git-send-email-shobhit.kumar@intel.com>
 <1430818458-26922-1-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1888936198=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1430818458-26922-1-git-send-email-shobhit.kumar@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Shobhit Kumar <shobhit.kumar@intel.com>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org


--===============1888936198==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2015 at 03:04:18PM +0530, Shobhit Kumar wrote:
> In case some drivers are unloading, they can remove lookup tables which
> they would have registered during their load time to avoid redundant
> entries if loaded again
>=20
> v2: Ccing maintainers
> v3: Correct the subject line (Lee jones)
>=20
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
> ---
>  drivers/pwm/core.c  | 17 +++++++++++++++++
>  include/linux/pwm.h |  5 +++++
>  2 files changed, 22 insertions(+)

Applied, thanks.

Thierry

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVSgcvAAoJEN0jrNd/PrOhiSUQAIESMz5YzUSx33V7D7DfUoBy
kvtYLcGYZDLIPd9TTB2aa9Zm1ANxTwbjmrw6HAjB3LcdEXtQGvyY76vm4EsbsdQW
/AhwqUKz+vhBsumjBiyGD5JHQ71m1MSEi1zHfIftmkLohkv6zPLOfanrfk7zJxJJ
KeAbIl0jkHKp83Y5Wty6W7Eb7Vpy5Yx4xBNoCTh05sueSBv1tTemTVF+cu0QvOJM
VU/CmoDPMhvFSymhh/9kG+5vjKaypIqqQ4OJweMskaOHwhapnjt5kydcf70S1bPZ
zOFNXhIQ7mWOhXVtUpvSo6rugD4QlHr1AzDwHkKvhR6x7lHFZ0fHeRCC1P8UllLX
qmtHFT2DzVHxvt9f1kW8i2gyiNYiZ8/gdIdK4tGE/V+d1vMuYKX4U4xhdu0C4UAf
pEUxOdqdaD3gQwtLS4hzJUk4aNggzm8v6U8uTGwPxfQoWIMt09cEGJiGWZ5FpLSx
N4tiGsZUFLXo41amjJGv53nlcu9qt4VKhBkOGyd94IQgd3zeuoNsPv3vSG8Xczci
yOpoiwzEV3Iov82NvT40IRy/iMgMDSzCxuosOpSbPMa9RfOoMTa1cetgH79c+U4V
1/3lCEO6qLWHq0dHADUcblnV59+usv3nDeqpfuAYDjgosE+tVTlCB7h2qab7kNTO
rZLXxuxmUcfHLyrrdqjS
=QFMs
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

--===============1888936198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============1888936198==--
