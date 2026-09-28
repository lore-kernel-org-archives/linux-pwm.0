Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DE930C619
	for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621067; cv=none; b=WmtQeFS4Mse8w0pCC5vGlR3DuW0rZmdG434fk/xYNeuCIu+gBQ9JvD4zrxqinqnEfh0H9KO63HMyqjMIHmGdTKOjazZeEM6de28RhJIdzcPuahVsjf9HaMm0YQWBqerbORpc5SvyP+sO0Eff2NKCczG9Ga/GHT6KP64wYOdIRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621067; c=relaxed/simple;
	bh=mKQj9sL5GzjoP859FR9c+/hLRYrlJtnFUUhUpb5S7SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfgTz6j98XgwzYCKW3sYHmAetKMU2W0TyZYlkYWi7uzb/xvQonXC8hl7/Mhx4WcmaGf8/yXrwpeGOh3uyjioijIJktfD7+P3NSomyeshk7XtZMt34y6Mm8wEMCQ1Hs5hYdr+xgO3dChJQr0UvchPfuHyG8eWtJWh5TL68Kro27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNclKgzH; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNclKgzH"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d817a94745so1094231eaf.1
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621064; x=1791225864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GjngKdONij+Xmo9yaF52FWFWceIK5m01Syn4FcsVzZ4=;
        b=TNclKgzHzP2XnNtVpJu1eQKRy3jMjt2U7NPuDj6e2RejQXs/SRQp3HMngOuv73dN+8
         b+ltFaQGTJ+TusCuW7/mDa4tj2JMNj/V87goMYndnlL0/Nz/5ejW0CHUVuHwm2OEiE54
         ezKVFuSqJVEdsVrLThTn/nToLz9xjrvIuT+R1548R1N+rnM3lw5lj/6Aur5x3aba79a8
         uyzPcl8VXkaxuIsJtnBU8+qFd0HgMl8fg5NGmgU7dmVANj/17D7Prv+siFJj+wNARUOA
         HaY7aDa5Bv5lG9PLAW1i/s2p+utuhkwy2hrX0tFJKcJnT7HLJ0dqWB26v7thUpxJbJSa
         yJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621064; x=1791225864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GjngKdONij+Xmo9yaF52FWFWceIK5m01Syn4FcsVzZ4=;
        b=aBV0TiovIJN5+I+3mvjgF3bHDKILIFfQh114iZi8Vu4VUWd+WhJ0+qcCPu1VvOa39W
         4USV9CAoSMfmP/ITZ4p4qK+NpatrmiucQx5h5oRUEXDERyjK+BEGn6az3FEmbDRFNRK9
         Yz6ueEFQ3FV+Yizx+NqTSV6IikwcA/cY0iIsySnEKHTChzgzL0aWAD/tEwkCEH/EkyfQ
         8ijKhdXorownAL3LsK1kPh1dkIVxCsaldN8ToxFUAl2BvOKaYH+2QH+0epeVZWXwbIas
         ek3qcUJ2QfZ/yogpoBorVieNhdMsmvg0MMl6Wce57Jn8q9JAaXjgJOEwnJjpDcNtpoTe
         /M8w==
X-Gm-Message-State: AFuF++kJ8XmAzAzSePT5yOC3KoOOlAootaqCkHyNAI4Fkl1pi/C3StwE
	rMtqhg01D1p5D32AgBI0L+5Yu+JZzMZB20WBkUDnANqvofFTR2LcRRfkzT/wFA==
X-Gm-Gg: AYBFou1NgNZPcqR+MrmLZoXpouE4vvjoB2yWCyqBNQHNaoGiplUu5XrFb0jT2OStnUB
	/kR3OztqmyX/2LHfpY0ac7ZKiOG059QDrOQG/WzemdbpUbXM1wSGo6eppvic7mshMeQJAwMkf3z
	u0WU/tbYL3ld9OTh2VIySQLCuuC3/DRH0+DL8XQea3pT9HFomAAGQXPdlwj2uFcpAcWkDmndDbv
	HkYVpPhflkXhwteid3Oey78t4LRpieg5gmn0aM4M5RBlJhJ8iVvG5RmqxzmFdmozcsezYbu9yXC
	qNM4r5isvYQAl0NWOaDGGImKBH1WHZmq37cdOOpV3ZFXskmlxWOqnMEYNirUKJBstwnLdjWgnch
	sDfnrXawXl/rsY8fh+bpCtwabO+zqa3XrUZKxmw3DV/ujFds+jbOPKAytbxFT1V6FaNey46BTiR
	ffpUvyNdbZWICISSOKSRo2LeELZ7AvoH3fSl74TSP3ZYeu2otfIVJn2WQjNBO9aYjkPljv7+Pb8
	jchXH3HdwCswUT8spN3OIIAYAfe7kbZXaNgqNiJ
X-Received: by 2002:a05:6820:88b:b0:6cd:3fcc:96d2 with SMTP id 006d021491bc7-6d440b0c2dcmr13316774eaf.80.1790621064248;
        Mon, 28 Sep 2026 11:44:24 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d8822199dasm5889946eaf.4.2026.09.28.11.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:44:23 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] pwm: Allow 32-bit tasks to use the character device
Date: Mon, 28 Sep 2026 13:44:22 -0500
Message-ID: <20260928184422.380520-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pwm_cdev_fileops has no .compat_ioctl, so every ioctl on /dev/pwmchipN
fails with -ENOTTY for 32-bit tasks on a 64-bit kernel, e.g. armhf
userspace on arm64.

struct pwmchip_waveform has the same layout for 32-bit and 64-bit tasks,
so compat_ptr_ioctl() is enough. PWM_IOCTL_REQUEST and PWM_IOCTL_FREE
take an integer rather than a pointer, which is fine too: compat_ptr()
only changed the value on s390, which dropped compat support in v6.19.

Fixes: 9c06f26ba5f5 ("pwm: Add support for pwmchip devices for faster and easier userspace access")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested on x86_64 in QEMU (pwm/for-next 17dbb6938d3a plus this patch,
    KASAN and lockdep) with a PCA9685 instantiated on i2c-stub, which gets
    /dev/pwmchip0. A test program runs all six ioctls, including the error
    cases (hwpwm out of range or not requested, __pad != 0, use after FREE,
    SETEXACTWF returning -EDOM):
    
    - before: every ioctl from the -m32 build fails with -ENOTTY, while the
      64-bit build works
    - after: the -m32 output matches the 64-bit output line for line
    
    No splats. W=1 builds are clean for arm64 (COMPAT=y, LLVM=1) and for
    i386 (no COMPAT).

 drivers/pwm/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2a050ff4608b..4c6d716e5fde 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2389,6 +2389,7 @@ static const struct file_operations pwm_cdev_fileops = {
 	.release = pwm_cdev_release,
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = pwm_cdev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 static dev_t pwm_devt;

base-commit: 17dbb6938d3ab444cd6be1c95506450595a8800d
-- 
2.55.0

