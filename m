From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] pwm: Convert period and duty cycle to u64
Date: Fri, 15 Nov 2019 11:32:24 +0100
Message-ID: <20191115103224.GA944026@ulmo>
References: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
 <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
 <20191016101539.GC1303817@ulmo>
 <20191017060247.GA12487@codeaurora.org>
 <20191017104313.GA3122066@ulmo>
 <20191115092745.GA21025@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191115092745.GA21025@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, kernel-team@android.com, Mark Salyzyn <salyzyn@google.com>, Sandeep Patil <sspatil@google.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 01:27:45AM -0800, Guru Das Srinagesh wrote:
> Hi Thierry,
>=20
> On Thu, Oct 17, 2019 at 12:43:13PM +0200, Thierry Reding wrote:
> > On Wed, Oct 16, 2019 at 11:02:47PM -0700, Guru Das Srinagesh wrote:
> > > On Wed, Oct 16, 2019 at 12:15:39PM +0200, Thierry Reding wrote:
> > > > On Tue, Oct 15, 2019 at 07:11:39PM -0700, Guru Das Srinagesh wrote:
> > > > > Because period and duty cycle are defined as ints with units of
> > > > > nanoseconds, the maximum time duration that can be set is limited=
 to
> > > > > ~2.147 seconds. Change their definitions to u64 so that higher du=
rations
> > > > > may be set.
> > > > >=20
> > > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > > ---
> > > > >  drivers/pwm/core.c  |  4 ++--
> > > > >  drivers/pwm/sysfs.c | 10 +++++-----
> > > > >  include/linux/pwm.h | 16 ++++++++--------
> > > > >  3 files changed, 15 insertions(+), 15 deletions(-)
> > > >=20
> > > > Actually, we can't do that without further preparatory work. The re=
ason
> > > > is that consumers use the period and duty_cycle members in computat=
ions
> > > > of their own, which lead to errors such as this:
> > > >=20
> > > > 	armv7l-unknown-linux-gnueabihf-ld: drivers/video/backlight/pwm_bl.=
o: in function `pwm_backlight_probe':
> > > > 	pwm_bl.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'
> > > >=20
> > > > So I think we need to audit all consumers carefully and make sure t=
hat
> > > > they use do_div() where necessary to avoid such errors.
> > > >=20
> > > > Thierry
> > >=20
> > > Hi Thierry,
> > >=20
> > > I would like to try doing the preparatory work by fixing the errors s=
een
> > > in consumers so that this u64 patch may be applied without issues.
> > >=20
> > > Before sending the patch, I tried "make"-ing for arm, arm64 and i386
> > > architectures to check for compilation/linking errors and encountered
> > > none. I see that the above error arises from using a cross-compiler f=
or
> > > arm v7, which I haven't tried yet.
> > >=20
> > > Could you please provide details of the compile tests that you run at
> > > your end? I could then try to reproduce the errors you see in the
> > > consumer drivers and fix them. Please do share any other ideas or
> > > suggestions you may have in this regard.
> >=20
> > I keep a set of scripts in the pwm/ subdirectory of the following
> > repository:
> >=20
> > 	https://github.com/thierryreding/scripts
> >=20
> > Typically what I do is run:
> >=20
> > 	$ /path/to/scripts.git/pwm/build --jobs 13 --color
> >=20
> > That requires a bit of setup for the cross-compilers. I have the
> > following in my ~/.cross-compile file:
> >=20
> > 	path: $HOME/pbs-stage1/bin:$HOME/toolchain/avr32/bin:$HOME/toolchain/u=
nicore32/bin
> > 	arm: armv7l-unknown-linux-gnueabihf-
> > 	arm64: aarch64-unknown-linux-gnu-
> > 	avr32: avr32-
> > 	blackfin: bfin-unknown-elf-
> > 	mips: mips-linux-gnu-
> > 	unicore32: unicore32-linux-
> > 	riscv: riscv64-linux-gnu-
> > 	x86:
> > 	x86_64:
> >=20
> > The blackfin and unicore32 builds are expected to fail because the
> > blackfin architecture was removed and there's no recent enough kernel
> > publicly available for unicore32.
> >=20
> > The last two entries in .cross-compile indicate that builds are native,
> > so regular gcc from the build system will be used.
> >=20
> > Most of these compilers I've built from scratch using pbs-stage1:
> >=20
> > 	https://github.com/thierryreding/pbs-stage1
> >=20
> > Note that I don't guarantee that that build system works for anyone but
> > myself, but I'd be happy to hear feedback if you decide to use it. That
> > said, you can probably find prebuilt toolchains for all of the above in
> > a number of locations, like:
> >=20
> > 	https://mirrors.edge.kernel.org/pub/tools/crosstool/
> >=20
> > or:
> >=20
> > 	https://toolchains.bootlin.com/
> >=20
> > Thierry
>=20
> I tried replicating your compilation setup and found that it worked
> right out of the box with no serious issues. I decided to build the
> compilers from scratch and only had to update my make to the latest
> version and also install help2man and u-boot-tools on my Ubuntu machine.
>=20
> I found your setup very easy to use on the whole and very well designed.
> I added a "set -x" to the /path/to/scripts.git/build/pwm script in order
> to figure out how it worked initially.=20
>=20
> I didn't add the lines for unicore32 and blackfin in my ~/.cross-compile
> file as you had indicated that they were expected to fail. It was very
> convenient for me to run the build command for a specific arch by
> appending its name to the end of the command you provided and thus
> verify that the compilation errors I was getting were getting fixed for
> that arch. Then by simply dropping the architecture's name from the end
> I could run the build command for all archs - very cool.

Great that it's working for you!

> That said, I wasn't able to compile-test avr32 and x86_64. I couldn't
> find avr32 in the targets folder of the pbs-stage1 git repo and so
> couldn't build it from scratch, and I couldn't find a pre-built version
> either.

I use a version that I once downloaded from the Atmel website, though
that was 4 years ago and it doesn't look like they're distributing that
file anymore. I never managed to build a custom version of the cross-
compiler for that because support was never merged into mainline of the
GNU tools.

In any case, we don't really have to worry about that very much because
AVR32 support was dropped in Linux v4.12.

> There isn't a config for x86_64 in
> /path/to/scripts.git/pwm/configs and so the build/pwm script wasn't
> picking it up even though I had added a blank line for it in
> ~/.cross-compile. Those are the only two issues I encountered with
> replicating your setup.

I could probably add a 64-bit x86 configuration to make sure we've got
that covered as well.

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3OfrUACgkQ3SOs138+
s6EF5w/6Aok2TXRHpBoqNwTuPLdailH7SSBMYylRlN3dpI/wjVmyjrwtaK1L73Du
MD8g6iQM+1xhIXVDGzvMLE1abGGFgksopQrKc3gu+F5iNki2HlO0zonZhn5J47M6
2SKevWUSGJ2FZDeMIZ41l6PmL0OMdS9ckdTbn1askkymYCun+rUzySzMy3uulDTl
kGq7jdpfVNHFOKk3gVKU2u2uH0wbBkbfDWy2759K08szYE33WfuDKVw9Y4RWKt19
qaV06K3NdmXXSGFKz/Q3VtcLqqPNBp8Nnx88rNq4NNvi3xYoOaJqpQk1At4HXOuq
1mhMXFt/VLUKHdz3I1YfHBQMZV4alIyHZaMxq/JvvdbDKHpX7K1ieWrIqdsv/xZf
Px4wcengLXDCJ471hhEXA70WdUNm3oDroYIbTuVYAioVLmHVO3Y2QEwFWWRbFa7i
J51sIuo9kISgJsEwFr3m1pk73xMORhRbSZ4FgbZStr8ochgf2hN04xmDMfExp4/o
2WT4kxO3lWbK+kzxyVhRpPEV1otDwuuAz96PyFwgO10U1v0Rhc8Y7G26Vupjgf28
thzoTc/ipSh6L5G9929Ajsi0ZIzOA/Fdxmc/JxXPV59Jqz/ftKLwttYhqZxlzd/J
2TuJAzWOd39sQNw/0eF0zUtuT4EIUdqVIWZs5R2jvR6LuGmpgCQ=
=47Ym
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
