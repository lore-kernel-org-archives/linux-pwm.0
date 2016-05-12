From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: pwm: atmel: PWM may not properly disable
Date: Thu, 12 May 2016 14:14:02 +0200
Message-ID: <20160512121402.GA26824@ulmo.ba.sec>
References: <CABDcavZXCGWGajRucaFztg98KCoUi-bLxV1fj+j8mW+WdSuLBQ@mail.gmail.com>
 <20160511133905.GA15651@ulmo.ba.sec>
 <CABDcavZi6ofS5YUTicV8EeASMn1gG8J9X5KZidkxCf=aVZXEFg@mail.gmail.com>
 <CABDcavYxH2B34vtAdVz=173A0Z0iEY7aNZJ1paFAt8xan5B1MQ@mail.gmail.com>
 <CABDcavZv3KSz4a5s3f5iusF6rCnyT2-10HCR1Ns5SaJuAwptxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABDcavZv3KSz4a5s3f5iusF6rCnyT2-10HCR1Ns5SaJuAwptxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-pwm@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2016 at 01:49:12PM +0200, Guillermo Rodriguez Garcia wrote:
> Hello,
>=20
> [...]
> >>> One thing that I'd request is that instead of the cpu_relax() you use=
 a
> >>> usleep_range() within the loop instead. I assume it can potentially t=
ake
> >>> a long time for the current period to finish, so busy looping isn't s=
uch
> >>> a great idea. You could possibly use the current period_ns to derive a
> >>> meaningful value to pass to usleep_range().
> >>
> >> I am not sure yet but I believe disabling does not really need to wait=
 for the
> >> current period to finish (at least the datasheets do not mention this =
anywhere).
> >> I think that the after writing to PWM_DIS, the actual disable operatio=
n is
> >> initiated immediately in the PWM subsystem, but is executed asynchrono=
usly
> >> and requires the pwm_clk to complete. If this assumption is correct, p=
erhaps
> >> it is enough to do one single read from PWM_SR so that the disable ope=
ration
> >> has had the chance to propagate. This is again assuming that all opera=
tions
> >> are executed sequentially within the PWM subsystem.
> >>
> >> If the above is correct, then we would not need a loop at all.
> >
> > I was wrong. The required delay indeed seems to depend on the current P=
WM
> > frequency, suggesting that indeed disabling does not take effect until
> > the current
> > period is finished.
> >
> > I will prepare a patch using usleep_range instead of cpu_relax.
>=20
> I have found a problem while preparing this. If I use usleep_range I
> keep running
> into "BUG: scheduling while atomic". This is because I am using the PWM to
> drive a buzzer with pwm-beeper, and pwm-beeper currently crashes if the P=
WM
> driver sleeps. Apparently this patch is needed:
>=20
> https://lkml.org/lkml/2016/2/22/757
>=20
> However this has not been merged yet.
>=20
> How should I proceed ?

The PWM API really shouldn't be used within atomic contexts. There was a
change recently that marked all of the PWM devices as "might sleep". The
reason for the change was that we introduced a mutex in pwm_enable() and
hence every user would have to deal with this eventually. That mutex has
since been removed again, but the fact remains that users shouldn't
assume that a PWM can be used in atomic context, because the PWM chip
could equally well be behind a slow bus such as I2C and hence sleep for
every register access.

So the correct thing to do would be to follow what leds-pwm did and
implement a workqueue. Also might as well make it the only code path as
Dmitry suggested in the linked thread, I don't see any point in any kind
of fast path here.

Thierry

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXNHOHAAoJEN0jrNd/PrOhXPwP/0wyhGmco8BROzoZjj9ynTRn
kb5qMADD264SPuW0RLr4qFyWR8go4jHt9iURobSRwsPqUJUg5uppefdkpLxoQvYA
A79BUVP9ruZMVIRA9J11FV0b7QslWHOqdb0kTfK/356bHxtKwQm6wrccDEC8xRT+
ySqqoD9zU9V0CoX41FFhIX4bt0S3ezlHoW1rVUSbjveYeRoAGRdaRxG3Uj6Sj56X
LtSstbB4YqPqrDMy2zKP4/ylCaTETo+KoknCQxlRRBoOqfbVlKrq/WUJ18S/bV8l
MGJwbb6DFiDEmTGj4Ygr8w1hwgrkZhHTlK3N6BNEHOLjbh5fiAfqUOf56uzTedUr
toGmu/l87ZhDzz8ch2O8g9nse9ELs3/UmIR3DeumrPl/UoNlxRMDNDahvwFcoHB1
JN3LfxAEozHvFOFt8qVshmWz38hhH8JJYprxNE4WeoFwBOLdbY4qqpJQ1qj6PbWX
xXBErrUVZ7/O3XQcTiNFPVlInf5b/2cEwrcpAhvRdES6qQuUkmJI+JaCLfVZCSRm
VibZ6wp+ieszgkzGPdr65r1fTSL0JBeBDYwdGJM8TIzhYLxCu4Ea1lNJkkBbv3rM
xN2zBx+rnrO/XioT2hwFzzPwKzdkZfFMuN5J5hF4YyE/vmLosBzvyLoDBA72VA3O
H1gLXenEhaDrMKzWfE6n
=Cnvd
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
