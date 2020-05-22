From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Date: Fri, 22 May 2020 14:50:28 +0200
Message-ID: <20200522125028.GG2163848@ulmo>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell>
 <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
 <20200424221422.GA31118@codeaurora.org>
 <20200427064434.GA3559@dell>
 <20200520231508.GA29437@codeaurora.org>
 <20200521071505.GL271301@dell>
 <20200522111657.GA2163848@ulmo>
 <20200522113147.GU271301@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200522113147.GU271301@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Thompson <daniel.thompson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>
List-Id: linux-pwm@vger.kernel.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 12:31:47PM +0100, Lee Jones wrote:
> On Fri, 22 May 2020, Thierry Reding wrote:
>=20
> > On Thu, May 21, 2020 at 08:15:05AM +0100, Lee Jones wrote:
> > > On Wed, 20 May 2020, Guru Das Srinagesh wrote:
> > >=20
> > > > On Mon, Apr 27, 2020 at 07:44:34AM +0100, Lee Jones wrote:
> > > > > On Fri, 24 Apr 2020, Guru Das Srinagesh wrote:
> > > > >=20
> > > > > > On Fri, Apr 24, 2020 at 07:43:03AM +0100, Lee Jones wrote:
> > > > > > > A great deal of mailing lists contain numerous protections ag=
ainst
> > > > > > > things like flooding and spamming.  One of those protections =
is a
> > > > > > > check for "Too many recipients to the message".  Most of the =
time this
> > > > > > > simply requires moderator intervention by way of review and a=
pproval,
> > > > > > > but this ultimately depends on the ML's configuration.
> > > > > > >=20
> > > > > > > The first thing to ascertain is why your recipients list is s=
o large.
> > > > > > > Have you added every reviewer, subsystem-maintainer, maintain=
er and
> > > > > > > contributor suggested by get-maintainer.pl?  If so, consider =
pruning
> > > > > > > that a little.  Contributors do not tend to care about subseq=
uent
> > > > > > > changes to a file.  As someone who receives a lot of patches,=
 I tend
> > > > > > > to get fed-up when receiving patches simply because I made a =
change X
> > > > > > > years ago.  Stick to listed maintainers/reviewers in the first
> > > > > > > instance and see how far that takes you.
> > > > > >=20
> > > > > > Thank you for the detailed reply. I did this in the first few p=
atchsets
> > > > > > and then when a few patches didn't get any attention, expanded =
the
> > > > > > audience thus. Still, around 50% of the patches in this series =
remain
> > > > > > unreviewed by anyone.
> > > > >=20
> > > > > This isn't a reason to add more recipients (who are likely to care
> > > > > even less than your original group).  However it *is* a good argu=
ment
> > > > > for including all of the specified maintainers/reviewers in on al=
l of
> > > > > the patches.
> > > > >=20
> > > > > > > If your recipients list is as succinct as reasonably possible=
, maybe
> > > > > > > just accept that every version isn't going to be archived by =
every
> > > > > > > ML.  It's still much more useful for the correct people to ha=
ve
> > > > > > > visibility into the set than for it to be archived multiple t=
imes.
> > > > > >=20
> > > > > > Thank you, will prune the list and remove past contributors fro=
m the
> > > > > > Cc-list and add all parties to all patches.
> > > > >=20
> > > > > Great.  Once you've done that, we can start to help you acquire t=
he
> > > > > Acks you need on your remaining patches.
> > > >=20
> > > > Hi Lee, Thierry, Uwe,
> > > >=20
> > > > In v14 of this patchset I've pruned the list of contributors, remov=
ed
> > > > past contributors from the cc-list, and added all parties to all pa=
tches
> > > > (except for the patches that are yet to reviewed, for which I've ad=
ded
> > > > what get_maintainer.pl showed me). I've also resent v14 a couple of
> > > > times already, with around a week's time interval between resends, =
and
> > > > somehow it seems like this set has lost traction.
> > > >=20
> > > > Could you please indicate what next steps I should take to have more
> > > > eyes on the unreviewed patches? Only 4 out of 11 patches remain
> > > > unreviewed.
> > >=20
> > > Looks like we're waiting on Thierry (again).
> > >=20
> > > This has been a common theme over the past few months.
> > >=20
> > > Perhaps he has changed employer/project?
> >=20
> > My work on PWM is purely done in my spare time. I don't get paid for any
> > of it. I currently have two kids that need home-schooling, as many
> > others probably do, and I have a full time job doing non-PWM related
> > things. As a result my spare time is close to nil these days.
>=20
> This is no different to many others.  I too am not paid for this work,
> but it's still my responsibly to ensure a reply within a reasonable
> amount of time.

I realize that this is the same for many others. Still, you seemed to
suggest that the lack of time that I was able to spend on PWM was
somehow related to me changing employers, so I wanted to clarify that
this isn't=20

> We can all appreciate that the latest situation has exacerbated issues,
> but a reasonable level of PWM participation, blocking various
> patch-sets has been lacking for months before we'd even heard of
> Covid-19 [0].

Covid-19 started to impact me around mid-March, and you'll see that
that's about the time that I stopped maintaining patchwork.

> If you need help, just ask for it.

Hm... who do you go and ask for help? Every maintainer I know is already
at least as busy as I am.

> I am willing to step up and review patches if you're overloaded. Uwe
> is already listed as a designated reviewer. Perhaps between the 3 of
> us we can work something out in order to reduce the latency.

That's very kind of you. Yes, I'd be willing to do this as a sort of
group maintenance, and perhaps even eventually step away from my role
as maintainer entirely if I think somebody else will do a better job.
I do still care about the PWM subsystem, having looked after it for a
couple of years, so I do want any hand-off to be somewhat orderly.

> [0] https://patchwork.ozlabs.org/project/linux-pwm/list/
>=20
> > I very much appreciate all the effort that others have spent in getting
> > this reviewed. I haven't been able to keep a very close eye on this, but
> > even the latest versions have some comments, so I didn't consider this
> > ready yet. If that's changed and everybody's okay with the changes, then
> > I can apply this to for-next. We haven't got all that much time left
> > before the merge window and I had hoped this would be ready earlier so
> > that we'd have more time for this in linux-next. But I'd be willing to
> > at least give it a try. If it starts to look like there are going to be
> > issues with this I can always back them out and we can have another go
> > next release.
>=20
> If you would be so kind as to review the PWM patches, I can take them
> in but I can't do anything without your Ack.

Looking at v14 I think there are no longer any discussions (looks like
the last comment I thought was from v14 was actually on v13 and it seems
to have been solved in v14 now) and there are Acked-bys for all the non-
PWM patches, so there's nothing in the way of me applying this to the
PWM tree. I can let it soak there for a few days and send out a stable
branch if anyone needs it if there aren't any huge issues.

Does that sound like a plan?

Thierry

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7HypIACgkQ3SOs138+
s6EgBBAAhRHwPHK5y0SWm5bZRqathEB+GQMA0YBvbOyLXuS/GeZv6CQjMGzKuYgb
54WqjNBLgxJb8TGS8swQbRgS8uhYHNmNPHV787Xx0zL8DGZNTAE+0LRUSOVCK9lK
HrIA8SqQskNkaNdM74mZNgkdR+JyRST3N/uYRm8Q5nLEqwKM2en7alyC6CeknrmE
BNwM+QvXKcc9IRbUUDWTVYws2HK3lBZbKUVoleMtco7eLSmhTahpEamTcU0lVbZY
cxT6yiT1gwjNJhk7A+QWh4L4dT/JuKZry86xjIPDgYaoPsPljqUShxNBq0aBsz0B
WCWg2Pd4jI78nl0lxCX1RulsjJQQyMS7LlZxq8y3WC0n7OGAfRLdVVFbyLy4+6QK
zC9g3EtFbGsFoR+L51FEWhcUbtofRLeKyvXKITyy54yoUock83K3Nal6pmFmMkrl
Hv61xHX70O8HBKS6V/h3pQnvKvNBMmovo4A4JmkkSjCe9lxKh/OY+Fg2ZoEqUsk0
+L5LoHBhaCmsQwzWFUU0TYMPBpXxjLvB//NqElaJXSAKNtqXTYZT6qjojqmJ3JMU
Kjalgac/13FKW03ULijqo6to1iWkCv3MJGqvSs0G/qDuyx2LCPAfKQw1PbJUGlQp
+7KQCICqtGQquv8fFm3Od7u1HkUXJWYD498MeaQ0VUx4rY9grYA=
=ysCw
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
