From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] clk: Remove CLK_IS_BASIC clk flag
Date: Fri, 26 Apr 2019 17:24:58 +0200
Message-ID: <20190426152458.GC19559@ulmo>
References: <20190425181447.60726-1-sboyd@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190425181447.60726-1-sboyd@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 11:14:47AM -0700, Stephen Boyd wrote:
> This flag was historically used to indicate that a clk is a "basic" type
> of clk like a mux, divider, gate, etc. This never turned out to be very
> useful though because it was hard to cleanly split "basic" clks from
> other clks in a system. This one flag was a way for type introspection
> and it just didn't scale. If anything, it was used by the TI clk driver
> to indicate that a clk_hw wasn't contained in the SoC specific clk
> structure. We can get rid of this define now that TI is finding those
> clks a different way.
>=20
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: <linux-mips@vger.kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: <linux-pwm@vger.kernel.org>
> Cc: <linux-amlogic@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/mips/alchemy/common/clock.c     | 2 +-
>  drivers/clk/clk-composite.c          | 2 +-
>  drivers/clk/clk-divider.c            | 2 +-
>  drivers/clk/clk-fixed-factor.c       | 2 +-
>  drivers/clk/clk-fixed-rate.c         | 2 +-
>  drivers/clk/clk-fractional-divider.c | 2 +-
>  drivers/clk/clk-gate.c               | 2 +-
>  drivers/clk/clk-gpio.c               | 2 +-
>  drivers/clk/clk-mux.c                | 2 +-
>  drivers/clk/clk-pwm.c                | 2 +-
>  drivers/clk/clk.c                    | 1 -
>  drivers/clk/mmp/clk-gate.c           | 2 +-
>  drivers/pwm/pwm-meson.c              | 2 +-
>  include/linux/clk-provider.h         | 2 +-
>  14 files changed, 13 insertions(+), 14 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDIsoACgkQ3SOs138+
s6EeYw/+ODtlfFBeX5N8+RMkQjbVCHXWEOdXzaRchdA6FG2OsXcE4sKemUaRndwq
39u//Gfd7+FzbRx1KozJynxMh4X4SZgkz8amg9E5KBMjxviapvni7zPs0iM4DCxU
QaD9lX+z7SHTjAmGO2Uc9WwOzGn7hKiawSaaWt3feFeycPQ19yz/oK9OT/gMtVh9
23fYY03Ct7m9jp7q9xfM6/03IO6QzA3ygvStbpHw06rQWVVO94z4RCziJKXEqwRE
zgqW+2tRCeBH6lx2wi6PHbPYpVvKCV/tGMFwjhDcfKgkWaCq/A3iGyJprnALkJV9
alCoVZ9RaxddQaxGo+nYI7Tf65j+jKsEZNDFO/rLL7uAsojJdI5SntyKJjZNJU/P
oELMbraTQV/YJD+CfuzDzCnX+hQ6HxD49TcP2G3hPPYFwfJPNXjTMxztThFghdcU
zUxEewHp36MCmxrCbB62AlySj013FdvXQPRWsbCK8WoPdAlS9RrDc7Fkq4rIcKvq
7qAdfSYKyRQDAAp62gjDQJLkGlolGAKGR6vxJTcm7PaH7hfSY87rQLTxbqaZvB4/
Be/PnMpG+OvwbGpMX6syEMcHVRoJwbJ3YP97GlPfFyQe8lj8gOumdN072Pe1LjsM
7wC7CgOqybPOzXwmDIXOTQkoVhJAYuxdmfxK3u31WbVhbQKBX34=
=IL2D
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
