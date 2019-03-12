Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 12 Mar 2019 13:28:35 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190312122835.GN31026@ulmo>
References: <20190312094249.27806-1-u.kleine-koenig@pengutronix.de>
 <20190312113944.GI31026@ulmo>
 <20190312120355.dfpcmuetcr56klbp@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H7cT1SUwsqXggVRO"
Content-Disposition: inline
In-Reply-To: <20190312120355.dfpcmuetcr56klbp@pengutronix.de>
Subject: Re: [PATCH] pwm: poke users of legacy drivers with a warning
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--H7cT1SUwsqXggVRO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 01:03:55PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Mar 12, 2019 at 12:39:44PM +0100, Thierry Reding wrote:
> > On Tue, Mar 12, 2019 at 10:42:49AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > As it is hard to convert a given driver from the legacy functions
> > > (.enable, .disable, .config) to the atomic stuff (.apply) without
> > > testing make users aware that there is something to do with a warning=
 to
> > > eventually get rid of the legacy drivers.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/core.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > I don't think that's a good idea. What are regular users supposed to do
> > when they see this warning?
>=20
> Ask on this list for directions or volunteer as tester.

I don't think that's fair to expect from users. There's nothing risky
about using a legacy API driver, so users shouldn't need to do anything.
This is a maintenance issue that users don't have to be concerned about.

> Then in a few years we can as a next step make these drivers fail to
> probe if they are still unfixed.

Erm... no. Why would you want to purposely break a driver that's working
perfectly fine?

> If you don't agree I wonder how you want to complete the task to convert
> all drivers to the atomic API.

There's technically nothing wrong with using the legacy API. It's worked
well for a number of years and a large number of drivers. We have
helpers that allow atomic API users to work with legacy API drivers.
=46rom my point of view there's no need to convert drivers that work fine
with the legacy API.

That said, it would be nice if it did happen eventually, if for no other
reason than to get rid of the compatibility shims, which aren't really
that bad in the first place. But I think the conversion could be done in
a relatively automated way. pwm_apply_state() codifies what the sequence
of calls is for the atomic API, so that's the sequence that ->apply()
would need to implement as well, given the existing legacy callbacks.
Another way of saying this is to push pwm_apply_state() down into driver
implementations. That's probably not the ideal way of implementing the
changes in a driver, but it's certainly one that should work.

Thierry

--H7cT1SUwsqXggVRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHpfAACgkQ3SOs138+
s6FzLw//UKDI3zcZIbOvmbapzBg/xNz+LWC5piuMqWp3RvLDIPNCF5lxrsHQatJY
KvmiXFtOCIGXYKnAO6+5GXo7Au6ftW63QMLz/2AeemqHfKkXsL7OtKfrLfvJ4b7E
t14ZFTXXJjgq5jWhij6I6HPV+0e5zdpYw1FVrx5Ch4Olg0pZATjydVM88/ptnO1D
/Q9oUJ3YLmKY4+y9oHwE9JtuE4w9JHxLzad66Z5irNHacw1YB4uTv0OtAHEdt6lD
65JlvJzv6fSQhiDF3Q4Psq2WvKXIJDUz7ar1hyhc0sYda9N8l8E9Zao03zQQ45qE
lEHqmTmoOmtK2+bEQt2ZyCp47P71wmM6e3h2O4m9meoLiMU3m8oRj9eeR8+uPZqN
bTZ/s7KeQLFetpQguz+UfMAZHmSNGSR3HtPocpMuRHi9e0jUl44ZPFBvQa9f40Rq
HYu6kwJuPbhsf6awya04jRfaOSYt9kC88T/vmsaaCzCUsHGHUywgyiCJlncSgofC
zCILLcZRq2suTCQ0IbSvXdKhLuFIKgX0IGLQJ8UkTJjSHhaQA3xJC82iYi61TAHk
CLwXrVlOXIOwrmBkaJuC1VvIjS3U7qcZ4w8gxOH/kvpPfvj9MjwHA4hZiPEkM2dz
vot8vpbvg2Yi8JEab1qAI3oGuN9ZcYkBMXIi5in0zvaZxy02QYU=
=QYL7
-----END PGP SIGNATURE-----

--H7cT1SUwsqXggVRO--
