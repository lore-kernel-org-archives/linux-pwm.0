From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Mon, 10 Mar 2014 13:22:39 +0100
Message-ID: <20140310122237.GA26681@ulmo.nvidia.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
 <6028232.VHmxlGjlXi@avalon>
 <CAKohponXNmXPZP2Umz3BfRnXyOPX5Fa9606Lc42ORnOuevifEw@mail.gmail.com>
 <24037035.nXcZgi4Mc2@avalon>
 <005801cf39db$e1a37240$a4ea56c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:43103 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbaCJMWm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Mar 2014 08:22:42 -0400
Received: by mail-bk0-f49.google.com with SMTP id my13so1154953bkb.22
        for <linux-pwm@vger.kernel.org>; Mon, 10 Mar 2014 05:22:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <005801cf39db$e1a37240$a4ea56c0$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pwm@vger.kernel.org, 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Joe Perches' <joe@perches.com>, 'Andrew Morton' <akpm@linux-foundation.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2014 at 05:04:36PM +0900, Jingoo Han wrote:
> On Thursday, March 06, 2014 1:30 AM, Laurent Pinchart wrote:
> > On Thursday 06 March 2014 00:17:38 Viresh Kumar wrote:
> > > On 5 March 2014 19:00, Laurent Pinchart wrote:
> > > > Sure, but I wasn't sure whether all error code paths in kmalloc() r=
esulted
> > > > in an OOM message. For instance, the following code path results in=
 an
> > > > allocation failure but doesn't seem to print an OOM message:
> > > >
> > > > kmalloc
> > > > __kmalloc
> > > > __do_kmalloc
> > > > slab_alloc
> > > > slab_should_failslab
> > > > should_failslab
> > > > should_fail
> > > >
> > > > A bit far-fetched possibly as it requires fault injection. I haven'=
t found
> > > > any other such code path, but my understanding of that code is a bit
> > > > limited.
> > >
> > > In that case should we actually accept patches like this at all? As t=
hey
> > > might be ending up removing some useful print messages?
> >=20
> > Dan has pointed out that I've missed the fail_dump() call in should_fai=
l().
> > One could argue that fail_dump() wouldn't print any message if the fault
> > injection framework has verbosity set to 0, but I suppose we can assume=
 that
> > people using the fault injection framework know what they're doing.
> >=20
> > All other error paths in kmalloc() seem to result in a message being pr=
inted.
> > I might have missed something, but I can trust the developers who know =
that
> > code much better than I do that kmalloc() is designed to print an error
> > message in all error paths. Any failure to print a message would be a
> > kmalloc() bug that should be fixed, and getting rid of the allocation e=
rror
> > messages in drivers would seem like a nice cleanup to me.
>=20
> Hi Thierry Reding,
>=20
> There seems to be no objection. :-)
> Would you accept these patches?
> Thank you.

All 9 patches applied, thanks.

Thierry

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHa6NAAoJEN0jrNd/PrOhu+oP/Rz8abjjOCYWdPUwPLumBFhg
zOdcGcbpADSVtA4PI/Njoyco7uWfVPU39S2AwnyFGQFyIGXrB60ngaLPVTmz7QcX
rz2RCtw1gpF4FDOuEhF4QnG5o5OxHpEeUy9064v7zJD6PWH0LjQrvtpjLAB409TQ
X8ifME61vhB5RrON2h11de+eBh4KKuEOPyJ1PEG061AegPwuRg9nu4gqfE2YcXS9
lkPxx16Bm0UC94laZ4W8xTtbm/le0/aQBw4xrsf6VZBtrf2E4mGFu63O1WPQdvmw
ZTdg+w3E8xhV4RRgEdof+OxStofUGL3b4mwVblmVxuooFvxFl6Q//7zwEh5T7eTn
zlWSSHewD4wjGxcYfTCWCoDnu6hD8IhuN6SbyAOA/30Uq4iM5ZugThSqZ3niwUzW
RE2xV0dz4+mLscU3zhdBOmgMDKIKd9jVFFkpqZ+4tiYK5Y9wqKYj1x7BlnFevTlZ
DKckus9iD8O1yslW08ZAv+UrVvI2lzY9l3yj6TBh50CNX0bq6VsCGmBaixuvGoLT
48C9hXbTyRpM6sjoblgIeBFekW8l84vypktBp7m92dkxq43rI3LepBhWe8QNXHHH
qmtvikw+mFWXvq6ab1Ofl7hMcUNc7rzRHl6q3YKqvZAVyMCHILhQzt/8xGjHZhBB
pwQOvBtxFqH0/c21nvrQ
=B0aK
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
