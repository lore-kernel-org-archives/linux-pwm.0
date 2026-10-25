Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955788;
	b=0UOvOYb9l7C1MJ0UeQDN0J14uPeKgTOe9CEGOftQhNuPD8O3gZSozCikZIerKWi3KxSt
	 ok/0XCOeMo4TsUhXc3r7ktV4j3I3rxs+oV1OUMeLbso8Fu1B/kWc60H8e3zKL6kQqioS/
	 zN1iTt+yQ+Dh7r+PBRgPQcCSa9WkHy13tW+PZ1wyHiPuSOlmdC76DZd/FSX8H7nThiXtU
	 IvoW3+c+HO/tyoRqFFPqiIbMUmqMfzEhOw5t7M9/uoNXzAELkzbksF4Avq19i9ZxE5dLW
	 VRaHMumgmOB1NxQ6Ni01Gv6tk40W2/i84m3OIZudm1S2zv9YYlCx1g9OCJUSP9xQVlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dsKEoWn0J6eZRSfAvhzwhCyUkWA5eiqJ4y72mpKVBNU=;
	b=L4H3YEksaLqWGa+d5v3JsLl/Lj648WiC47pWXIvXMe9/u2hn6ultpxX0/zTHcAlV0paL
	 SKoNM9ZOfYw0HdMqVJV3jWH9DE5gYkZFb/tH7+dW5sESx8TGioYZYbj73vJbYk5VwBJFo
	 Cv8hKkZsUkjoLd61nNEadsU3CDHjIm/sdxq/7hLYo3xuFcaLKtiYa8fT63kfWaGEL+bv+
	 mFXqRGyfzsoHwmLnadlzyo3VWYwT1nruIT50XXJxqj+knuggyKiffo7rbv61DEgRLv24Y
	 FVqzWuxKds1Sud6fD9kopJ/4ttbdfE+6a7HxSQr7uwD4nuI3OAZdnE7EU2mnkgcANJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=VTvXvSik;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B18606A31A
	for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 19:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B18606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=VTvXvSik
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e4831c028so731779f8f.0
        for <linux-pwm@vger.kernel.org>; Sun, 25 Oct 2026 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792955786; x=1793560586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dsKEoWn0J6eZRSfAvhzwhCyUkWA5eiqJ4y72mpKVBNU=;
        b=VTvXvSikLfJGslamcvpxzCJTu9WkCqjiJqpiEmRb3NyqMiAEDAZqGiMJOtgonAhvVe
         ghVqAx1FnE16xEaww+LmUM3JTFBWGkrjBFsQlyG/IdXi2YGFwzny5206DDVamb8N1MGh
         cAfRYHnoGVF63+UjNmuJm0Sn3D99fSfvJFaUV2DjMknY2UjvCIJL4FyhRSOrznDeFOBV
         liWh36MSsxs/4AcMi2HmaxivN7SLlfqr/r5HQIp+4u0Asqk/CSyU+BluZIGLCmNB28TC
         YEoChXByW7WkhkxR9+w3vExNtNv2TtfBR9fafQblnxFRZfD7O5NPhGQo187Ak4APjsFn
         sBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792955786; x=1793560586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dsKEoWn0J6eZRSfAvhzwhCyUkWA5eiqJ4y72mpKVBNU=;
        b=bbSVXr5eo5T1VasBadiw1RRuONdcTgHoD2BdETEpYLq6gdqNnLXRO3mZ0FL5RHbnHO
         rUfTh9Kor2zm/ES7o1yUF+ofFQdcIsIB0ClEADXoyjpD5PI/wTrQfEb6tOEfCs0HkliQ
         7IYBdommEja7X1OOvmF5tO4diHGJS85wAr/KiomA7OigzOSceGB1mLd0BVtjhrke8PPJ
         bHSZfgl5pr5YjnIb0DtJ24Q4nXgxflMnfGX/krfskfKnBPSODZqZTozK6j7VJnoNycJn
         61aCxWxA+/RdyK+vhLXvSZbsluLUPf6KdCTQMZQ7XIEIVUG5Yt7bY9P2ZRoPKYn0oK0c
         2rmQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2PXYuWKdwAJSGRam1kxkKO8dRdJNfh7YdlE/M8KqB9yP+kZIyQvJUgUMEbXFn3vHlsrUK6vQB1XA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpc1o3b0T6CDxgBcP0htfPnbIocyhg3qpXZ2/NQxLrPSpkKEjZ
	JQvjqA/IcKmX/fU+hkeCcTDRyKXf5plk4LzqzQ2K5jiv1kVtmPSr61pReqp1rg0zBKU=
X-Gm-Gg: AYBFou0UOXLRZQvzHBuotd4UMJK5CpMrundme4rpTwACuGqZkQW0ExThj+JzEN0vpEH
	CgGqyYHN92qM8XpasvtmjC1Mr3tonmYEV1uJTsphCnrrHT++eJ8x1DpNoD0ExV1MZfJA6bJ1RNx
	+IMYV/PuSLnLQm0a5kXHTkI21/ze/dCLo3LqeGcryyL0XVIAdPbwzJ1JjhimH56fLK9H2C4hwOv
	v4d6/cCO+IVTFJnqR5t+XG9eS0O4ROxmqtWpbl1ZiKSmMMWmZ4XbfQeWYyt/XloqVt6SiZK84Y8
	saey67ESOw5ooDY9tsozDhv3TYdQcXLanaTqHSzmzHbrt4/8iS4l7GsegMgPnJv/SsIhf2YDtAb
	Bn1s3udr4NeuZklJciGrnukCmG/oLaPkiNEidxCN5oDf0GknZtXcifFebWXhONMKGTlF02vWwGR
	ZQlWdjq75NFcPEzFhu7GtfsuRcNxNIUFwoDSufUdhvXXvlYwsd8ILcC7ggP50tweKciHxTMNTac
	d894FbUp97HFsjyAg3g/U1gBpkQR8q0UNDWr5K2nbR+JlXFS3E6CoNcxgWI61JbcFbFIotylWLH
	izjw1cFjORCJpgzJwwSl54XW39d3pTNYLQM=
X-Received: by 2002:a05:6000:4b04:b0:48d:fbe1:bb17 with SMTP id ffacd0b85a97d-48e3eb7ca4emr8944736f8f.41.1792955785830;
        Sun, 25 Oct 2026 12:16:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bcdsm10082051f8f.13.2026.10.25.12.16.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 12:16:25 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 0/2] pwm: Add the Ingenic X1600 PWM controller
Date: Sun, 25 Oct 2026 20:16:22 +0100
Message-ID: <20261025191624.9219-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ingenic X1600 has a PWM controller of its own, separate from the TCU
timers that pwm-jz4740 drives on the earlier Ingenic SoCs. This adds its
binding and a driver built on the waveform callbacks.

Changes in v2 (both found by the Sashiko review of v1):
- A channel that is off with both counts still loaded, as one stopped
  behind the driver's back leaves it, now reads back as disabled. v1 read
  it as running, so asking for the same waveform again didn't switch it
  on. A channel off with one count zero is how 0 and 100% are written; the
  idle level gives which.
- A clock rate of 0 is refused with -EINVAL when rounding a waveform and
  when writing one, instead of switching the channel off silently or
  dividing by zero in the update timeout.

Tested on a HiBy R1 (X1600), whose backlight is channel 0, through
pwm-backlight: brightness 1, 25, 50, 60 and 100% give the expected high and
low counts, 0 and 100% switch the channel off at the right idle level,
and an inversed 250 us of 1 ms on channel 1 reads back as INL 0, LOW
9375 then HIGH 28125 with the clock divided by 8. PWM_DEBUG stayed
silent. For v2 also: channel 1 running 250 us of 1 ms, switched off
through ENC directly, then requested again through sysfs, reads back as
disabled, and the same waveform asked again switches it back on; v1's
driver read it as enabled and left it off.

The X1600 has no device tree upstream yet; its support is being posted
one subsystem at a time.

v1: https://lore.kernel.org/r/20261025084643.93167-1-olivier@mgcrea.io

Olivier Louvignes (2):
  dt-bindings: pwm: Add the Ingenic X1600 PWM controller
  pwm: Add a driver for the Ingenic X1600 PWM controller

 .../bindings/pwm/ingenic,x1600-pwm.yaml       |  47 +++
 MAINTAINERS                                   |   6 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ingenic-x1600.c               | 280 ++++++++++++++++++
 5 files changed, 345 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ingenic-x1600.c


base-commit: 00e917df050d79ac26ec700717680ad6421d2808
-- 
2.39.5

