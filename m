From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH 0/6] pwm: imx: Provide atomic operation for IMX PWM
 driver
Date: Tue, 25 Oct 2016 09:07:24 +0200
Message-ID: <20161025090724.727c10bc@jawa>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <20161024173607.36bc2cb9@bbrezillon>
        <20161024232615.77d4ea28@jawa>
        <35a950b7ff431e0545bbb259ba69b483@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/6.BrC5b98dV1RSa+MU+emnv"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35a950b7ff431e0545bbb259ba69b483@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

--Sig_/6.BrC5b98dV1RSa+MU+emnv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Hi Lukasz,
>=20
> Thanks for your work, great to see this coming along! :-)
>=20
> On 2016-10-24 23:26, Lukasz Majewski wrote:
> > Hi Boris,
> >=20
> >> On Sun, 23 Oct 2016 23:45:40 +0200
> >> Lukasz Majewski <l.majewski@majess.pl> wrote:
> >>
> >> > This patch set brings atomic operation to i.MX's PWMv2 driver.
> >> >
> >> > This work has been supported and suggested by Boris Brezillon [1]
> >> > and Stefan Agner, by showing how simple the transition could
> >> > be :-).
> >> >
> >> > It has been divided into several steps:
> >> > - Separate PWMv1 commits from "generic" and non atomic PWM code.
> >> >
> >> >   NOTE: Since I do not have board with PWMv1, I would like to ask
> >> > somebody for testing
> >> >
> >> > - Move some imx_config_v2 code to separate functions
> >> >
> >> > - Provide PWM atomic implementation (the ->apply() driver) in a
> >> > single patch for better readability.
> >> >
> >> > - Remove redundant PWM code (disable, enable, config callbacks)
> >> >
> >> > - Clean up the driver infrastructure
> >> >
> >> > - Provide "polarity_supported" flag to indicate support for
> >> > polarity inversion
> >> >
> >> > This work should be applied on top of following commits:
> >> >
> >> > http://patchwork.ozlabs.org/patch/679706/
> > [2]
> >=20
> >> > http://patchwork.ozlabs.org/patch/679707/
> > [3]
> >=20
> >> > http://patchwork.ozlabs.org/patch/679680/
> >>
> >> I'm not sure I follow the logic here. Has patch [1] already been
> >> applied? If that's not the case, then you should just drop it and
> >> put your changes on top of mainline.
> >>
> >> [1]http://patchwork.ozlabs.org/patch/679680/
> >=20
> > Patches [2] and [3] have been developed initially by Lothar and
> > subsequently picked up by Bhuvanchandra. There is no issue with
> > them.
>=20
> As such none of this will get merged since all patchset have known
> flaws...
>=20
> Generally, it is ok to refer to other patchset being a prerequisite,
> but that only makes sense if those patch set are still actively
> worked on (by somebody other than you).
>=20
> In this case I really recommend to create a new, complete patchset.
>=20
> >=20
> > The patch [1] is a bit more tricky. The work has been done by
> > Bhuvanchandra, which adds DTS and core support for polarity
> > inversion.
> >=20
> > This code works and utilizes the "old" PWM API with enable, disable
> > and config. However, Stefan had some comments about the placement
> > for the polarity setting (in the .config_v2()) and proposed switch
> > to atomic API.
>=20
> Part of the reason I advocated for the atomic API is to make adding
> the polarity functionality easier. It does not archive this goal if
> we add the "flawed" code first and then transition to the atomic API.
>=20
> >=20
> > To make things easier and cleaner, I decided to put my atomic API
> > rework on top of those patches. In this way I can credit the
> > previous work and avoid rewriting DTS polarity inversion code
> > already developed and validated by Bhuvanchandra.
>=20
> When you apply the patches using git apply, the authorship and
> signoffs will stay. There is no problem in including other peoples
> work into your patchset, credit will still be given. If you have to
> change another persons patch, you typically also add your signoff to
> show that you worked on it too.

I do wanted to reuse as much work as possible (especially that the code
was working).

>=20
> Here is how I would do it:
>=20
> 1. Start a new branch from mainline (or even -next).

With the newest mainline 4.9-rcX
SHA:0c2b6dc4fd4fa13796b319aae969a009f03222c6

the i.MX6q is not booting. Apparently I do need to wait for things to
calm down.

The last working version is v4.8, which PWM's code is the same as v4.7.

> 2. Implement the transition to the new atomic API and test it as such
> alone (this way we have no polarity support influence yet, just clean
> transition to a new API)

I _just_ needed to add polarity support (by setting one bit) to the
driver, so I ended up with rewriting the whole PWM i.MX driver :-).

> 3. Cherry pick the PWM core changes for the optional 2/3 args driver
> support (they should apply cleanly)
> 4. Cherry pick (they likely will fail to merge) or reimplement the PWM
> polarity driver changes on top of atomic API
> 5. Cherry pick device tree changes
>=20
> With this approach we'll end up with a nice history where we should
> end up with a fully functional PWM system between every patch.

I'm fine with proposed approach. I will prepare v2 of patches soon.

>=20
> Btw, past perfect tense is not really usual in commit messages.
> SubmittingPatches chapter 2 has some tips on writing good commit
> messages:
> https://www.kernel.org/doc/Documentation/SubmittingPatches

OK.

Thanks you for your support,

Best regards,

=C5=81ukasz Majewski

>=20
> --
> Stefan


--Sig_/6.BrC5b98dV1RSa+MU+emnv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgPBLIACgkQf9/hG2YwgjFLtgCgzgTqnVOV3iFp12RsW9nX2XBW
/TEAn1JaO81ULIhp37c2bA5s9zk6e7+9
=cBed
-----END PGP SIGNATURE-----

--Sig_/6.BrC5b98dV1RSa+MU+emnv--
