From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Create device class for pwm channels
Date: Wed, 15 Jun 2016 16:37:20 +0200
Message-ID: <20160615143720.GA23483@ulmo.ba.sec>
References: <20160615021204.GA11507@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160615021204.GA11507@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, David Hsu <davidhsu@google.com>
List-Id: linux-pwm@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 07:12:04PM -0700, Greg KH wrote:
> From: David Hsu <davidhsu@google.com>
>=20
> Pwm channels don't send uevents when exported, this change adds the
> channels to a pwm class and set their device type to pwm_channel so
> uevents are sent.
>=20
> To do this properly, the device names need to change to uniquely
> identify a channel.  This change is from pwmN to pwm-(chip->base):N
>=20
> Signed-off-by: David Hsu <davidhsu@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/pwm.txt |    6 ++++--
>  drivers/pwm/sysfs.c   |   15 ++++++++++++---
>  2 files changed, 16 insertions(+), 5 deletions(-)
>=20
> Note, this patch came from David with his work on a system that has
> dynamic PWM devices and channels, and we needed some way to tell
> userspace what is going on when they are added or removed.  If anyone
> knows any other way of doing this that does not involve changing the pwm
> names, please let us know.

Is it truly PWM channels that dynamically appear and disappear? I'd be
interested in how that's achieved, because there are probably other
issues that will manifest if you do that. Do you have a pointer to the
work that David's been undertaking? Generally some more context on the
use-case would be helpful here.

Also I'd prefer if this avoided using chip->base here, because it exists
purely for legacy purposes and is supposed to go away eventually.

Thierry

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXYWgcAAoJEN0jrNd/PrOhZFYQALBO59hHHc9tzpjNnER/+zox
vyqK4SMDvTVMWZgtWdUIii1719D7CVx1FgZaVSypN5mHTKpJ/C96riWiGZlJ6k7w
vBokQyNixMOINoytRGO2H2H7t0nIKqGOHMJ6HPnWGOp5vfIEg1AJZNCJM8O+78yN
tcZzYjpVQGxsYhvWfvKNv7KOCBHPS6Cj4vvil6FNczYDyYrrLOaETQVM72Lu1ufr
L0dINhSiFm+gXZ+jMv8lY5ufI5FH9dppVrTrFnwjbzLVr8/o0faf4sYT0jtML8Wm
mzjvhKvazuFc5h86Lf4//9CMRBNnGyA6m81wcfYHGecUEF6Hnbeq5uTGjMSCI4iK
ba0wqKsHmVus7rqanoGKzHmj1IZ+y48J7KvRuoPIYj8ucjGdYVtxCnpPYkzpVGGb
RCLb/W4I+ymhLNy44h7ij0I09CLfwo9kdc1OhMefyfxNckxqe2vF3NquXD12/7lO
mOV23OXiD02utRqTeihaoFSLTtC3/IjZyrZGI+CtcnNvvwvFFqJmLgiAlM8H0Xh5
Z0rQfSM3iPPBVoVKEUzyADCS0UEzOxyJ/5/SA9U9//4Mm8jZm0gX1Fd62aVt4DlA
u+qXNlhCNCcnzPdrp1SNpfzWt4QxN4j0POiKqUrzt2WuNUdeN6+e1LyAbaTow77g
LGmjFmHP9D1aYLZqc5HP
=S4JN
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
