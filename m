From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: PWM DMA interface
Date: Thu, 19 Jun 2014 00:12:01 +0200
Message-ID: <20140618221200.GE26514@mithrandir>
References: <CFBB4FD9.4313A%gordon@raspberrypi.org>
 <20140617225401.GA25525@mithrandir>
 <61114322-BF2B-4E67-B4B9-30E20D7D60CD@raspberrypi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:47747 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbaFRWMF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jun 2014 18:12:05 -0400
Received: by mail-wg0-f47.google.com with SMTP id k14so1458012wgh.6
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2014 15:12:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <61114322-BF2B-4E67-B4B9-30E20D7D60CD@raspberrypi.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gordon Hollingworth <gordon@raspberrypi.org>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 18, 2014 at 08:20:58AM +0000, Gordon Hollingworth wrote:
> Yes within the limitations of the simple RC filter but basically it's
> working like a one bit DAC

Perhaps a better way to expose this, then, would be as a proper sound
device so that the standard ALSA tools can be used to play back audio
rather than needing a set of custom tools.

Thierry

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTog6wAAoJEN0jrNd/PrOhGrEP/RzkfcO7XN74UCGyyTSahaj2
t4F8GZ3Y+aL2/6UUC6mjRvqWN7wmBKVRYND2AqCGRnTD4w8sc0+WpRFttkiF0y6J
IC3ByFYaayBckl4LGUkw4KWB/gEdya7r3HVX2cevTOxLoT+we03i137lzQxmNwUK
P6sgvyZxFNp0bK7hpIPb9+SjVgeW1/Vo2b45Sp/VMLN/t0SOWGTZibq9utO3wJrR
DPXFj4wK9REwmiTEeoMPGRfJJSvDtsqcHhwfYPBxr6flLLjTi1z/NssRR7NeY0xu
sUjvTr0X3awP1JEJ56L8Rf9CE0lrU3IOWOkoVurOQD/jmerxx5PaHUJUcglYos5C
kOTuIaCZ9cJxS3KDzUN2CByhsJWLi0CPyd/GWGi+SJ+6ycIA1WdPTA8yc9oQx6YW
UUCEZzcF1DMTI1c0QM3g6EhSWIlVv/P3EMSo3i5BFyMEBuGxVclkjZHt9V2OM3LF
yszUDCk69SpamSPHmzhSDuRnsrn9VDAp/zeUZIiHCYP9/Lmdmxj9F7SskqHKSmLP
W0f5av8xmrEZ5tLnfsUxyOnOCwGVcSoNMIrNmYb5C1uOl+mEHLZQ3R02idZKcY0Y
6R7fYjriBlsFDYLSom/llM641xabnz9wbgCR+uJWSsax5SHqlOXCMKyNgCvuOUeK
I8nfuQKsjbbdP93hRvuj
=4FBo
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
