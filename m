From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: update lpss pwm driver to support Broxton platform
Date: Thu, 12 Mar 2015 08:58:36 +0100
Message-ID: <20150312075835.GC30344@ulmo.nvidia.com>
References: <1426170508-8273-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:46676 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbbCLH6l (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2015 03:58:41 -0400
Received: by pdev10 with SMTP id v10so18042638pde.13
        for <linux-pwm@vger.kernel.org>; Thu, 12 Mar 2015 00:58:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426170508-8273-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "qipeng.zha" <qipeng.zha@intel.com>
Cc: linux-pwm@vger.kernel.org, mika.westerberg@intel.com


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 10:28:28PM +0800, qipeng.zha wrote:
> From: "qipeng.zha" <qipeng.zha@intel.com>
>=20
> Add pci device id for Broxton platform.

For reference, this should be "PCI" and "ID", but I can fix those up
while applying.

Also, it's customary to include a changelog in subsequent versions of a
patch, as well as change the subject prefix to include the patch version
number. That makes it easier for other people to track things.

You can do so using:

	$ git format-patch --subject-prefix=3D'PATCH v2' ...

The changelog typically goes below the --- marker (the one below the
Signed-off-by line) and would look something like this:

---
Changes in v2:
- keep board information table sorted by device ID
- reuse Braswell board information

Again, no need to resend this time, but something to keep in mind for
future patches.

> Signed-off-by: qipeng.zha <qipeng.zha@intel.com>

I'd prefer a proper spelling of your name. Would "Qipeng Zha" be
correct?

Thierry

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAUcrAAoJEN0jrNd/PrOhA1kP/iZWMngjPl2aLRdmV8o+7GZX
ZzQYvM0nY/FmAP2KpHYsE6E8Fqth8HvdlRO4HJrKOk2Jlo5Bsgx3v0+FrHjZRseo
gZbk/8FRYCBuAtcbK17HT6KKXYQXiSDxeKHZCIO1lXF6ALiREe20fUT73wofUOj0
w0Xrl7wptkgILmMEgVZjjLIMHFVxsrVM7y7eFrbLe8UdnoM0aWHZzXVTjZu5I02V
zcgd7KU8iiqq689VbF1pFR4y1B0CP70zqdX1HTHwV7Gsk7QpNAN6dkzey7IBxLFd
+uTNLDJmI/ZjuGWnqIT8HH8e04jPQ7fk3cvTN8fM5FoYK4JIXi26i9n21jhaPqgV
WrkI2owJvOJLt8evl+/EF+z8qtBxS9a6VVgAu4XK4Sfo5a+VPLvqWwn9ynTOLC8U
EIqqtl0ECkWekRhr8+b77p0GfS2kPgLl6Wixf0ODInCMW5aAslKKmWmCgHv0qGAT
39c5nluIgULfkbuERjDnY14egjclaFJNzJRwlnxH0x+N68eEnbXouBrKfvflo3WA
iqv8Hd7Akhbpj085L3HCnReIoeeM1i2AMsEi5Up2ILt+85C8ocY0YUyMMuJsO0L/
yY1+7/stN53BxmpixeBfgXHkLHPq5XKmtSFNjAeSKofYAyu3A0U8qNjG7ujCg3RO
l/MFNxGHRfSVMSFBw/j5
=otx1
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
