From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
Date: Fri, 30 Jan 2015 12:18:54 +0100
Message-ID: <20150130111853.GA32359@ulmo>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
 <54BE3369.9000802@imgtec.com>
 <54CA6089.50505@imgtec.com>
 <20150130091832.GA16744@ulmo>
 <CAL1qeaH77fJuh8fM1tKJz0bizni1sErCy=EwZTzV=EY10dX9iA@mail.gmail.com>
 <20150130102612.GE16744@ulmo>
 <CAL1qeaEen_RM8da+KU-+O26M9Z7VksWG+C=C-Oa6cAhyjiXfug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL1qeaEen_RM8da+KU-+O26M9Z7VksWG+C=C-Oa6cAhyjiXfug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 11:08:46AM +0000, Andrew Bresticker wrote:
> +linux-mips
>=20
> On Fri, Jan 30, 2015 at 10:26 AM, Thierry Reding
> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Fri, Jan 30, 2015 at 09:50:46AM +0000, Andrew Bresticker wrote:
> >> > Also you're making it especially difficult to build-test by not
> >> > providing even the basic bits of your SoC support first. All even
> >> > linux-next seems to have for the Pistachio SoC is the addition of a
> >> > compatible string to the dw-mmc driver.
> >> >
> >> > I'll take the PWM driver, but I'll assume that you'll eventually have
> >> > more pieces available, in which case I'd appreciate a note so I can
> >> > update my build scripts.
> >>
> >> FYI, I'm hoping to post Pistachio platform support for 3.21.
> >
> > That'd be great. I can switch over to a proper defconfig then and not
> > jump through extra hoops to build test patches.
> >
> > Also, I'm seeing a bunch of weird errors from building MIPS, mostly
> > things like this:
> >
> >           CC      net/ipv4/netfilter/arp_tables.mod.o
> >         {standard input}: Assembler messages:
> >         {standard input}: Warning: .gnu_attribute 4,3 requires `softflo=
at'
> >
> > or this later on:
> >
> >         mips-linux-gnu-ld: Warning: vmlinuz uses -mhard-float (set by a=
rch/mips/boot/compressed/head.o), arch/mips/boot/compressed/decompress.o us=
es -msoft-float
> >
> > This is essentially a gpr_defconfig (because it select MIPS_ALCHEMY,
> > which in turns pulls in COMMON_CLK that PWM_IMG depends on) and then
> > enabling MFD_SYSCON on top so that all dependencies are met.
> >
> > What am I doing wrong?
>=20
> What version of binutils are you using?  I believe the latter error
> should be fixed by commit 842dfc11ea9a ("MIPS: Fix build with binutils
> 2.24.51+"), but perhaps the decompressor Makefile requires a fix as
> well?  Unfortunately I'm traveling for the next couple of days, but I
> may be able to take a look at it on Monday.

I use binutils 2.25, and indeed building the correct branch gets rid of
those errors. Sorry for the noise.

Thierry

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUy2idAAoJEN0jrNd/PrOhPj0P/jjwv5BjeA2bwEawIawUPAn2
8Uv3Vbvbdh9MAKwjtmqO3RMz+4Z4J+rskjjACo2mZalJHtoA3hDL799ENX25Hszp
BzgYc82vF1fY1vzKArKKO47h8j+PDH2vOuOxe6stZXn+RolihbBp/nOacjkSV3Fv
weCvQXFi1gPNFdTcjuDSK7oWkEJtj03TvvEYlr4Ve3TD7/bfSARMoP89t5enKwK9
/mPjqkvHRHiJLaA+DVFkeR7SIsZzdOSrcYJM8NOpLGEuKSPlritGtvN2XpQSOUWk
/XyzfoMApnt/051i0Zy/2kpsLLDyEq65gEL2u/qWq6Ti2xifzScggAsmBlw/ErSJ
bTXuWEDmeBIkJOhIk2WJmXt8frM9P39j+YHaWECkjPiGUx7ErMIVkPLB2OyghU7l
TsFC0H+NBWqst2/RQrKLtgF/qPe3uWyTk2Cv++4bxhO0eu6/KByycRMCSAJetIQd
NJb/nHYC7NcjJh35pMj5a/Y2LLckTMEVgzJaLIM5WSmn8m0YR52wedyV/E6Wwls0
UVpCpi1KfAeS92g6m1EmmpSqNPRzLzhnSCLe0netpkkD4mRysLtODV0mM8vfw/ZD
PYuP8fpZXNrjK6JjKhUbQSfSYNMnZTgglSjG4Q6qniS403bLSCE9cV7+HmzONL65
q0/n5U9BgrL6tvH7oQ//
=3n3v
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
