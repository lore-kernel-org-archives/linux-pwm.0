From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Tue, 10 Nov 2015 18:34:16 +0100
Message-ID: <20151110173416.GB21727@ulmo>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBGWVRCZAKGQEYS2TU3A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2341981.a79ioYM9Es@diego>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pen>
List-Id: linux-pwm@vger.kernel.org

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 12:12:12PM +0200, Heiko St=C3=BCbner wrote:
> Hi Thierry,
>=20
> Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
> > Hello,
> >=20
> > This series adds support for atomic PWM update, or IOW, the capability
> > to update all the parameters of a PWM device (enabled/disabled, period,
> > duty and polarity) in one go.
>=20
> is anything more blocking this series? It's now sitting on the lists for=
=20
> nearly a month and everybody seems happy with it, so it would be really n=
ice=20
> to have in mainline :-) .
>=20
> Especially as this also makes it possible for Rockchip Chromebooks to act=
ually=20
> control the logic-regulator that is implemented as pwm-regulator there.

Last time I tried to put this into linux-next I got immediately
bombarded by a number of build failures, so I backed things out. The
current plan is to give this another try after v4.4-rc1.

Thierry

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWQiqYAAoJEN0jrNd/PrOhXB8QAKiDQLBn34IqmLnCArNIwIs7
bSYy8AS8Zk60nIIf3a08UGJ0wY45T7zKpfkbKHvMIr7yKO3PfrbwRnaF7oCcYS4I
oVPrXQjIFN4sge7YV8sNIhr0yDKpcR/dTMlpu+oQmEgRIWyZv5qDtgYcyeiEMmtV
MQB8Tro7kMCju3YMRs7gLQ1n7Rv5WA2u5WP2I1bDw/wLA4WX1d7HRbL1MmCrFSXf
qvEL8s+Oj2NUjNNal95KqIMmwv1VlT821mOu/qv3xDJ2hoHk30wmnv/W9Dz0K8Xi
JOOcj0JJCzXGOSAbEWVbNLY0t4NcL+y5fC5O1uAUp9y1yhNoN0NcVA7invPMEZNz
EqFB/KnnKnDTWTo8wjrLgZQ9ZCpocVXE4QIKu98MhpXkNycaDXi2HPFGVbaNrWGn
cnZlNv3eXFK0J886l9ceEMVqTl9EtZRCstC1WMZWOBJ6vMaTnLt2X5ogoruu22oT
TW31cMIY88vLgF8PRwBo8tKjLGoym73loLwsYOaLs1kJruaf/w/J2NV3CYlG4Xq8
rbCMiGgEblSksxBhYCTjDTKB9NBPnDAezNul4GCZ/Ry1XVRngZdWpjzleokwpp9U
S7yVSosarAi487rWfG1Mc1nuvJtvZOwH8XQQbmru/oz3UrC9WX9PTdZUY8lF3ITy
Ghu9X0RQlSMJpsx5mlof
=77fz
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
