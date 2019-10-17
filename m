From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] pwm: Convert period and duty cycle to u64
Date: Thu, 17 Oct 2019 12:43:13 +0200
Message-ID: <20191017104313.GA3122066@ulmo>
References: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
 <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
 <20191016101539.GC1303817@ulmo>
 <20191017060247.GA12487@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191017060247.GA12487@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, kernel-team@android.com, Mark Salyzyn <salyzyn@google.com>, Sandeep Patil <sspatil@google.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 11:02:47PM -0700, Guru Das Srinagesh wrote:
> On Wed, Oct 16, 2019 at 12:15:39PM +0200, Thierry Reding wrote:
> > On Tue, Oct 15, 2019 at 07:11:39PM -0700, Guru Das Srinagesh wrote:
> > > Because period and duty cycle are defined as ints with units of
> > > nanoseconds, the maximum time duration that can be set is limited to
> > > ~2.147 seconds. Change their definitions to u64 so that higher durati=
ons
> > > may be set.
> > >=20
> > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > ---
> > >  drivers/pwm/core.c  |  4 ++--
> > >  drivers/pwm/sysfs.c | 10 +++++-----
> > >  include/linux/pwm.h | 16 ++++++++--------
> > >  3 files changed, 15 insertions(+), 15 deletions(-)
> >=20
> > Actually, we can't do that without further preparatory work. The reason
> > is that consumers use the period and duty_cycle members in computations
> > of their own, which lead to errors such as this:
> >=20
> > 	armv7l-unknown-linux-gnueabihf-ld: drivers/video/backlight/pwm_bl.o: i=
n function `pwm_backlight_probe':
> > 	pwm_bl.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'
> >=20
> > So I think we need to audit all consumers carefully and make sure that
> > they use do_div() where necessary to avoid such errors.
> >=20
> > Thierry
>=20
> Hi Thierry,
>=20
> I would like to try doing the preparatory work by fixing the errors seen
> in consumers so that this u64 patch may be applied without issues.
>=20
> Before sending the patch, I tried "make"-ing for arm, arm64 and i386
> architectures to check for compilation/linking errors and encountered
> none. I see that the above error arises from using a cross-compiler for
> arm v7, which I haven't tried yet.
>=20
> Could you please provide details of the compile tests that you run at
> your end? I could then try to reproduce the errors you see in the
> consumer drivers and fix them. Please do share any other ideas or
> suggestions you may have in this regard.

I keep a set of scripts in the pwm/ subdirectory of the following
repository:

	https://github.com/thierryreding/scripts

Typically what I do is run:

	$ /path/to/scripts.git/pwm/build --jobs 13 --color

That requires a bit of setup for the cross-compilers. I have the
following in my ~/.cross-compile file:

	path: $HOME/pbs-stage1/bin:$HOME/toolchain/avr32/bin:$HOME/toolchain/unico=
re32/bin
	arm: armv7l-unknown-linux-gnueabihf-
	arm64: aarch64-unknown-linux-gnu-
	avr32: avr32-
	blackfin: bfin-unknown-elf-
	mips: mips-linux-gnu-
	unicore32: unicore32-linux-
	riscv: riscv64-linux-gnu-
	x86:
	x86_64:

The blackfin and unicore32 builds are expected to fail because the
blackfin architecture was removed and there's no recent enough kernel
publicly available for unicore32.

The last two entries in .cross-compile indicate that builds are native,
so regular gcc from the build system will be used.

Most of these compilers I've built from scratch using pbs-stage1:

	https://github.com/thierryreding/pbs-stage1

Note that I don't guarantee that that build system works for anyone but
myself, but I'd be happy to hear feedback if you decide to use it. That
said, you can probably find prebuilt toolchains for all of the above in
a number of locations, like:

	https://mirrors.edge.kernel.org/pub/tools/crosstool/

or:

	https://toolchains.bootlin.com/

Thierry

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2oRb4ACgkQ3SOs138+
s6Eubg//QRlhY2yWMvDbi5TV86IHTijMq1mWsuyUNHqqIur8iqDzT8pyJfV13YP/
5CwTfBxc1LzYGzRq4woVEZiffrazudhVsjS0jA1ElxSRJX7RLG40KxVuGYH2fkCq
MU0kn0wZEIPCpAVyMr1/g8KQLc9QmGBcL5sPB2wUpKRsAmL3nSyZIiNtJkEM2d5g
w2V+YFN1ISY+gqp45f2v1jWWn+hSz6v1xzCyBIoaE80SPQ0aiU261ma/bARrUSzQ
MNFvpyBf8Fbc9PsWKq/cU3qEj7EDK9kFkZp8EqwBnr+tDCIDCxLLdGIt25q8mIQT
Gzgu2wO6NHcCH3wrKDzPiZUulwtiQ6XJfC+p7+77F3/SNSKFL2jL+cnc7P19F/Ub
W1KhCuraOjZvuSqS+hpiUUfKOw//gl2fsYcyEVgxT7xIKGflI9dcFWLB1tPe9LZP
vD2CXMsz5lsNV+hZN8gtFKt2A3LR902tovfYPqhbm2wy0oOakExbQGZPDWgN36iX
rgy7v+YDUj8MOSRowGmESniRIlYG7WfS063B/E+TASTfQonJ5UVZSc1oyKcWCh8Q
WkUHY3qW0SUqC4JrBOpyRJMAgYHVWuLI7vj8VcyyckwhqU3B3hkJO0KcQT4Vo8kY
YF7GsDp55zzoH563Tm3stx+uurmrA749F5QU5IZ6rZFe1itXaVQ=
=g7bs
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
