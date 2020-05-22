From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Date: Fri, 22 May 2020 13:16:57 +0200
Message-ID: <20200522111657.GA2163848@ulmo>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
 <20200520231508.GA29437@codeaurora.org>
 <20200521071505.GL271301@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgEVLRE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 07:17:04 -0400
Content-Disposition: inline
In-Reply-To: <20200521071505.GL271301@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Thompson <daniel.thompson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 08:15:05AM +0100, Lee Jones wrote:
> On Wed, 20 May 2020, Guru Das Srinagesh wrote:
>=20
> > On Mon, Apr 27, 2020 at 07:44:34AM +0100, Lee Jones wrote:
> > > On Fri, 24 Apr 2020, Guru Das Srinagesh wrote:
> > >=20
> > > > On Fri, Apr 24, 2020 at 07:43:03AM +0100, Lee Jones wrote:
> > > > > A great deal of mailing lists contain numerous protections against
> > > > > things like flooding and spamming.  One of those protections is a
> > > > > check for "Too many recipients to the message".  Most of the time=
 this
> > > > > simply requires moderator intervention by way of review and appro=
val,
> > > > > but this ultimately depends on the ML's configuration.
> > > > >=20
> > > > > The first thing to ascertain is why your recipients list is so la=
rge.
> > > > > Have you added every reviewer, subsystem-maintainer, maintainer a=
nd
> > > > > contributor suggested by get-maintainer.pl?  If so, consider prun=
ing
> > > > > that a little.  Contributors do not tend to care about subsequent
> > > > > changes to a file.  As someone who receives a lot of patches, I t=
end
> > > > > to get fed-up when receiving patches simply because I made a chan=
ge X
> > > > > years ago.  Stick to listed maintainers/reviewers in the first
> > > > > instance and see how far that takes you.
> > > >=20
> > > > Thank you for the detailed reply. I did this in the first few patch=
sets
> > > > and then when a few patches didn't get any attention, expanded the
> > > > audience thus. Still, around 50% of the patches in this series rema=
in
> > > > unreviewed by anyone.
> > >=20
> > > This isn't a reason to add more recipients (who are likely to care
> > > even less than your original group).  However it *is* a good argument
> > > for including all of the specified maintainers/reviewers in on all of
> > > the patches.
> > >=20
> > > > > If your recipients list is as succinct as reasonably possible, ma=
ybe
> > > > > just accept that every version isn't going to be archived by every
> > > > > ML.  It's still much more useful for the correct people to have
> > > > > visibility into the set than for it to be archived multiple times.
> > > >=20
> > > > Thank you, will prune the list and remove past contributors from the
> > > > Cc-list and add all parties to all patches.
> > >=20
> > > Great.  Once you've done that, we can start to help you acquire the
> > > Acks you need on your remaining patches.
> >=20
> > Hi Lee, Thierry, Uwe,
> >=20
> > In v14 of this patchset I've pruned the list of contributors, removed
> > past contributors from the cc-list, and added all parties to all patches
> > (except for the patches that are yet to reviewed, for which I've added
> > what get_maintainer.pl showed me). I've also resent v14 a couple of
> > times already, with around a week's time interval between resends, and
> > somehow it seems like this set has lost traction.
> >=20
> > Could you please indicate what next steps I should take to have more
> > eyes on the unreviewed patches? Only 4 out of 11 patches remain
> > unreviewed.
>=20
> Looks like we're waiting on Thierry (again).
>=20
> This has been a common theme over the past few months.
>=20
> Perhaps he has changed employer/project?

My work on PWM is purely done in my spare time. I don't get paid for any
of it. I currently have two kids that need home-schooling, as many
others probably do, and I have a full time job doing non-PWM related
things. As a result my spare time is close to nil these days.

I very much appreciate all the effort that others have spent in getting
this reviewed. I haven't been able to keep a very close eye on this, but
even the latest versions have some comments, so I didn't consider this
ready yet. If that's changed and everybody's okay with the changes, then
I can apply this to for-next. We haven't got all that much time left
before the merge window and I had hoped this would be ready earlier so
that we'd have more time for this in linux-next. But I'd be willing to
at least give it a try. If it starts to look like there are going to be
issues with this I can always back them out and we can have another go
next release.

Thierry

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7HtKYACgkQ3SOs138+
s6H5ZBAAoAqPDYAGotFEMnwiD82oNJe0dIuG+OV4t35cMTn1xEo2mpKWDYfKV0Hv
6aDWw/ZacV/jAG+4jjyPgLVyFiMZTvS57rpfwaVGPMzfjiEB1Y+3+J+QSCRlpOvL
jFd8a7rBGk3DdpYOzxM2HsQSmkcYJe/AAoG+XIHzuEBTafAl+DkLonWdBrDyMYD2
JDl07OJz7cVPptsOw2OosYDWLaQ7iHffxvzTvpPZ9hp8FDR6ryB9xCdbPYgjzuD+
bqUpCuqvPQmgTOSIxYZwS4km0ezXbSPP0Z27Df5f3GgXx+S1bn4rNrKG/lkgWwib
Ph8xbFRR1okONXRvoWTltWWDsgfAO9/aTV4rTjTEeg8C8siYTGspLkK/Elvgiftn
GYpSBtNA0ayIXGjYym8Jx67wNOp0J2tKFCtxNh31Viy5wGLExocaYgAcL3+Y6iAT
7cy5hKG2L83J79pXh05Ld2ge4qeqgGLKTYbBsS71IoLTKWTo08Cn/vdiAlbp3yQO
ucSeTCqJ4/vvZA4JE7TOJG1Y+XeZ41FMDCPgiVokW+KIrtpn+m+Tc7YYSdOO49eZ
/xUBwhn1RX+Lqg0eQN8WhgWAGpIvHSSHxPiGv3EwXfCzBNvnXSdMVf8eDCSU1kkg
x2DxGuTh90Kly/FX8hCgLRARx0GH/sAFCzSBJ2ntZnjVEshKC5A=
=b2vB
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
