Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4933BBA0B
	for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2026 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138553; cv=none; b=DMILNXeEgPyb2c1p+YeiLa+Zh0gkDPzSnRinVtljIHqDBCIvehJ5HAXEjhNhC2LbsSJc8pOpUGq8okiZm9JqMFp3cvbg+9kqIrL3bQ7RQ47DLWtLUH4S6Hy4tf14msAZvspq7JPJ8yeC4IZrHV5zCPT+wxnWv6rIxpZlWWK7NVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138553; c=relaxed/simple;
	bh=apFSD776yEKUsMejLW08NY7p2hwAd7avD6Zoj67sL3A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QrDIemlxA+J1aFdQep26LUrm2DgSqSEnRvwimasx51742nph54Ek+rGQxBZNqSKukqlxBsYS45KdyuJSeDgQr0ZEthFQGsCg7QUf22SI1fV/+1Pllm2Y7ayJL+AteLAZWvCdQTfMpa4y6v4f/WnRDORe38+jfWmNorfOI5i0FP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FiBR7BWR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FiBR7BWR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a02718da81so48828625e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2026 01:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792138549; x=1792743349; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8x4XnGD/4Oqx8bSJ/7ncc+zMyX6jZtywIR+ptTvzeSs=;
        b=FiBR7BWRp5wC78+T0Sk76QciZTMJnk9e3blIvUwb1u0T8lNgG2ksALMF+XC7o+UzmB
         P5Q9apOJQ6jbwpEfeS45vsjDQrnp13fUhVzKzDpnWS0SE3Qk3GYgbE2MOyQQPl7QsQU7
         tQPOIJdS1qdWaU7lsCXkuUPI22oqcdvNZSEuqEuveJ3mJTZTxTqUF0Lfpc1dURuL8K2a
         C++9/5duUOsFsVMDW3m4sPO4W97cyRR5xo47fqvfchI3v148cLH5dx/fZG1Tgs04ahAK
         0n9bk4rL6JOrZSSg7SsEMHHQuxCcof0NdVyaRq2esRbBiP9b+eHoU6XHAPJckUr+giXt
         9/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792138549; x=1792743349;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8x4XnGD/4Oqx8bSJ/7ncc+zMyX6jZtywIR+ptTvzeSs=;
        b=olrcBtRhZirHqhubP22IkRziV/eZcBmM1rz41SN0ddOwq05o8kJawlhw7A4FJfr992
         6+IKTWCKlZrYA6EDd1KK+GFX93J9bYR0icGif11NA+bPzXvhfUZEjxAGh0sLdEGgdCKh
         MOPygu4/wmVNxqJFfwI+OidkWVhjg2yBHu2vF22174qoBNi75X0AoISnGS7D1DfR5xRE
         31v1EaRqVbpby/RHflJVloFKGwYJQYkNaHXGwROVBzwtMdgEkiRI4rcRldFoNEza9CHH
         eRcBV9w7KZ4d0WkUoyxIIhSB34rCc1Go/BATWPurHi+MqrX9KV8ESPzNMa2rscmDf8N+
         zG6Q==
X-Gm-Message-State: AFq9FYKHFqTVeD8dJSO9hgGdhb9ajjOHnuniEZp5+AWyykwKxBR8NhbF
	wHPJpJHi3iTP/zo4T8xSkAdDiAxxfvnovs3Cy2K6vuVE0J8R/UFiRhcAFISSNRGCRBo/EY3lDH4
	JdanM
X-Gm-Gg: AYBFou3bwYUpXpCg2r593tJWagFUgddv4OgAcquWgKZJQPOrz2ZSlXW45hQMJ1IPWfi
	uEdC2bMjdTJDvZDUCZhiJBKeTlVGFSw4cAApWypoWyqjt18CzkJzFC5M2UJs55i094+PDlCR0lF
	7mRE+mJO6f6DktX4ANobEYsW1Q7gp2ENDshydSvNxUKNpJu3713RILfNpNIr90hOGC5EJb5Si6N
	IuqCQO5KO61K7AGsqONJhJ/3DrV0gKKO67moIqISujprw8b87j1RZocK70GXFo4+tRMRK8kI73k
	HGbw4UowI3DErNoNjlIjy/pbD9TP3iR+NwHnRffxpRncwrppFbOjBv0dFocnzDNt4gSal8Fb2uB
	2ltUfHSr9IJredSKxIfixpiocD2b0/LxODOroc8pms//1ub/8SOxC/U4JpqbzKs/fMFZIgzueuI
	sKTVeyULK7j9nm+NiD77+Wk0BQYZWMU4uwFtRl8eZ19HFToOIgQH3rzQv4kj4rG7lvzT/harD/l
	/KETNLdYE9zMQMvS/L2Mr58OpE2xkjfPkVBYVXndi6lIMs7n/27hgkPwVA3
X-Received: by 2002:a05:600c:1909:b0:4a0:2391:6529 with SMTP id 5b1f17b1804b1-4a18e4d3f12mr470601975e9.29.1792138548576;
        Fri, 16 Oct 2026 01:15:48 -0700 (PDT)
Received: from localhost (p200300f65f19a904af4079c70d984f00.dip0.t-ipconnect.de. [2003:f6:5f19:a904:af40:79c7:d98:4f00])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a1c8de8c58sm39262175e9.15.2026.10.16.01.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:15:47 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:15:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for 7.4-rc1
Message-ID: <atHZhAtSk7UGkVGX@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gllu2bouvaejzpvy"
Content-Disposition: inline


--gllu2bouvaejzpvy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 7.4-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-7.4-rc1

for you to fetch changes up to 00e917df050d79ac26ec700717680ad6421d2808:

  dt-bindings: pwm: Add IPQ5210 binding (2026-10-14 11:33:04 +0200)

for 7.4-rc1.

----------------------------------------------------------------
pwm: Changes for v7.4-rc1

The usual mix of fixes for older issues, devicetree changes and
cleanups.

Part of this is a shared branch that introduces device-managed variants
of atomic_notifier_chain_register() and
blocking_notifier_chain_register().

----------------------------------------------------------------

There are a few more interesting things still in my to-review queue, but
I didn't manage to review these in time to make this PR a bit more
interesting. (Though I guess you like it boring :-)

The series introducing the devm stuff for
{atomic,blocking}_notifier_chain_register() also touched iio, gpio,
platform/x86, input, acpi and kernel/reboot. I didn't check which of
these were picked up, but I guess you'll also get e38b9eda475f
("notifier: add device-managed registration APIs") via a few
more PRs this cycle.

Apart from the top-most patch (which is "only" a trivial device-tree
binding addition) these changes were included in next since
next-20260930 without any hassle.

Please pull this during the upcomming merge window leading to 7.4-rc1.

Have a nice week-end,
Uwe

Alexander Sverdlin (1):
      pwm: tiehrpwm: Clear period on disable to allow reconfiguration

Chen-Yu Tsai (1):
      pwm: mtk-disp: Fix period readback

Danish Khateeb (1):
      pwm: Allow 32-bit tasks to use the character device

Eduard Bostina (1):
      dt-bindings: pwm: Convert TI PWM Subsystem to DT schema

Eliav Farber (2):
      notifier: add device-managed registration APIs
      pwm: iqs620a: Use devm_blocking_notifier_chain_register()

Hemanth Selam (1):
      pwm: Fix typos in comments

Keguang Zhang (1):
      pwm: loongson: Reload PWM configuration through counter reset

Manuel Ebner (1):
      docs: pwm: Fix bracket and punctuation

Manush Prajwal (1):
      pwm: lp3943: fix NULL pointer dereference for an unconfigured channel
=20
Ruoyu Wang (1):
      pwm: renesas-tpu: Fix runtime PM reference leak

Surendra Singh Chouhan (1):
      pwm: ipq: Prevent potential 32-bit integer overflow in hi_div calcula=
tion

Uwe Kleine-K=F6nig (1):
      Merge tag 'devm_notifier_chain_register-for-7.4' of https://git.kerne=
l.org/pub/scm/linux/kernel/git/ukleinek/linux into HEAD

Varadarajan Narayanan (1):
      dt-bindings: pwm: Add IPQ5210 binding

 .../devicetree/bindings/pwm/pwm-tipwmss.txt        |  58 ------------
 .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  |   1 +
 .../devicetree/bindings/pwm/ti,am33xx-pwmss.yaml   |  82 ++++++++++++++++
 Documentation/driver-api/pwm.rst                   |   2 +-
 drivers/pwm/core.c                                 |   1 +
 drivers/pwm/pwm-brcmstb.c                          |   2 +-
 drivers/pwm/pwm-ipq.c                              |   2 +-
 drivers/pwm/pwm-iqs620a.c                          |  23 +----
 drivers/pwm/pwm-loongson.c                         |   2 +
 drivers/pwm/pwm-lp3943.c                           |   3 +
 drivers/pwm/pwm-mtk-disp.c                         |   4 +-
 drivers/pwm/pwm-pca9685.c                          |   2 +-
 drivers/pwm/pwm-renesas-tpu.c                      |  23 ++++-
 drivers/pwm/pwm-tiehrpwm.c                         |   3 +
 include/linux/notifier.h                           |   7 ++
 kernel/notifier.c                                  | 105 +++++++++++++++++=
++++
 16 files changed, 231 insertions(+), 89 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.y=
aml

--gllu2bouvaejzpvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrR3S8ACgkQj4D7WH0S
/k56awf/XGPoEp9Ha0pX108rafUC81Ymdd1Hl7hJ2KJG5DKbglBRWpENZZYuKPAK
dI6fYCBadtDr+yzAcZOrY44f4Eo/SpE8ix/gHWeWGBBfyVvzG1ZOdQEE+YEBYaEk
D+UiAn+eILPxnSotlPLwePK6ko1SvYWLYi9AL7WCnLd1+XfEh/Oj0NjcV2G+92hC
ypa0+R8tjVnhAp/wGjOQkI/ApZSdV7OaJqy7OGVCPvpp7MwPtIPODTUAFMJ6lABY
0laYwUdEcycw2JqY5kZGT8lrBKv97iQfVADqAy+dnd9+zA6oYbr1MAeW77OCEvlg
GuBVeKPysZmiour/xI8CBAyWRE59Ag==
=81RX
-----END PGP SIGNATURE-----

--gllu2bouvaejzpvy--
