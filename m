Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975929D26E
	for <linux-pwm@vger.kernel.org>; Fri, 24 Jul 2026 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784868545; cv=none; b=k2ympgBDz83KFdGO742Ij1sD/9WI/n4pTPfEOQUjiixfdmvm9x/vXS0bappiXwQjRDMxrLc9HNEjdAtK1F5U6fblB8eaPZHyNqLTC+YAoZd6QzxsB1aogi445WZ7ylyNiqo9PeSJ8KuU2lK/W2fTRm6zUER/XxWGIZ5sVLJE09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784868545; c=relaxed/simple;
	bh=jmxbrwT0ACsQ5mOq/PoKuhVXWl4DvzOqPCq0ZqbjROM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RT15GUGF0QHbK/2iVvkVSQNVT2Jh4BH1oUzNSPnlWJ7CoXkKbNieTLUKZnsprle7HJ/geCu+rjkWkid9a6PVkKX4gSRppKLzczLxFyh3JFZ0EgS9ngahjewOmLmia4z1O7PXJTzafRpdTXYJEZuM5LsqFxcvyiFtSPgFqlpQhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loG6h9mx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loG6h9mx"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848d21bbaffso947b3a.0
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jul 2026 21:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784868544; x=1785473344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4o8yWR70SV8gvAgkdxuV0aAhEqNnVvORCWUZx0xUnU=;
        b=loG6h9mxow+qBNioQXkgpKr1gTkKojfsbnQvcmW6tWtWiFUKMBU0GQzsqljt64fDnt
         fTCCc0Qc/mZrm1X9AyvqmfIbePZr01ck6ywQdfUgWLlQ/KncwZ07fmgPfKj4J9GHxmoQ
         3u/UBVUJxZfinG2NFQFCx3DvOEiPMAiU3LrGGgIdXIzTkx3OQ3naHqJ22WdGDfqmJE2E
         +UgySEQmrDho0O6R4U/sq+NV7UQa0d6Z6Jg4ZF9OPG+Pgf0mk2ha6dHVXXJbkXesOU7x
         I9hXBMDKn7Vi2BYxqIfFoGB70O1azo/s/+jwNrip4tAXAY6tcdq1x+ot726jFuOEdA1u
         xyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784868544; x=1785473344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4o8yWR70SV8gvAgkdxuV0aAhEqNnVvORCWUZx0xUnU=;
        b=bfX97mX5qWepyugJNvAjRgGClkQ2ymzl3tqc+M7MZxF14GSNJU9PppFlCaJBEUVfoG
         xJRwyqAO73YYIptTGHMvdG8JNz3zemiUYuxS2rGVbOTovOv+6fYEPfpCOSw7x5A87A90
         tnbZU8xe8BsHoOJHaWv6mF5CgRBI4P9TblJ78q7ZdVTkgoc8BRHbm7OzE7i+ZLHNymiX
         +NM3idO6TDao9MJoJY+nP6x4peBEarEjSBTUHpLSJwQp6kzhj6P0LRHWRNS9XDSezfNu
         4P0052sAF8lGYV4SfPlkveulOkzVNDAASwLVhqCuQWUszHGwMEiJmoGSTDfRjQgjs6Vo
         pxiw==
X-Forwarded-Encrypted: i=1; AHgh+Rp91XwpUtUOGV8dPf8+L7EJqvi+c4m2ZUuLck6fRUkiyaAqTChjgeRijxizZTd55ex9kVbg9/9H8IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziuvzs4hnrC+p2YMzLFw86RED3yI5Ij/SfyN7+4HxWSsA4tZq+
	mvaKour322fbIlJy1pgs4dUfvUHXdT3D4E88+CqCjbjy9qPZQRyl/uw=
X-Gm-Gg: AR+sD13Ukva8UH1yb1hY42LcARN1WrppxiDmeFez94I3eIl/waz1wP1UK2VRXD+cOpK
	lUsRRIc1SWm130+coXEMmbVvOjGIG3MZAp8oGC10pQX51kP07YLTFZOCYWAeucUWWrcHw0/clfT
	dMexU6ZPn2Q71Fzfo+20K766SLNahLGNNv1QuqGGJoHZ6bfowsamI4+lcjkw9B48yKxPHJZioz3
	G/COQ24jko1Fp8XHhlCV9MpqDow5ELcGT9ZqecTGwCNN0T5q3BJQj4C6IXdfi2LcTJD+lrs0+jH
	OqnR2086cc1YveLnGP/HBdgoH8jcZQIh/9f3W0Bvh1XVVdz4GKK8BMpJcFx4HUwYtSPDFNnpXdg
	yZFGhQ+h1yK7WDdCNTnLpOgUSFrkg9SZ56eE+b/2RWWEUinsQJybcPbGzKUBtvAqR9F3M9onIZ3
	ZdIHH8MBvsevtEB0gdF2UmcsgjTwk=
X-Received: by 2002:a05:6a20:b08d:b0:3c3:bbe6:95c9 with SMTP id adf61e73a8af0-3c44afccc22mr6236342637.16.1784868543731;
        Thu, 23 Jul 2026 21:49:03 -0700 (PDT)
Received: from t-rex ([2401:4900:7b3a:ad08:5f07:2836:b3b8:b712])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9f2f0sm26926887eec.13.2026.07.23.21.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 21:49:03 -0700 (PDT)
From: kr494167@gmail.com
To: ukleinek@kernel.org
Cc: george.moussalem@outlook.com,
	quic_devipriy@quicinc.com,
	andersson@kernel.org,
	baruch.siach@siklu.com,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Surendra Singh Chouhan <kr494167@gmail.com>
Subject: [PATCH] pwm: ipq: prevent potential 32-bit integer overflow in hi_div calculation
Date: Fri, 24 Jul 2026 10:18:54 +0530
Message-ID: <20260724044854.33274-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Surendra Singh Chouhan <kr494167@gmail.com>

In ipq_pwm_get_state(), hi_div was calculated as:
  hi_div = hi_dur * (pre_div + 1);

hi_dur and (pre_div + 1) are both unsigned int (32-bit) values.
Evaluating their multiplication using 32-bit arithmetic before assigning to
the 64-bit u64 hi_div variable can overflow 32-bit unsigned math.

While effective_div explicitly uses (u64)(pwm_div + 1) * (pre_div + 1) to
prevent overflow, hi_div was missing the (u64) cast.

Fix this by casting hi_dur to (u64) before multiplication, matching the
precision used for effective_div.

Fixes: c436e3e9c265 ("pwm: Driver for qualcomm ipq6018 pwm block")
Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
---
 drivers/pwm/pwm-ipq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
index c53373948136..e27ddc8e9fea 100644
--- a/drivers/pwm/pwm-ipq.c
+++ b/drivers/pwm/pwm-ipq.c
@@ -186,7 +186,7 @@ static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC,
 					   ipq_chip->clk_rate);
 
-	hi_div = hi_dur * (pre_div + 1);
+	hi_div = (u64)hi_dur * (pre_div + 1);
 	state->duty_cycle = DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC,
 					       ipq_chip->clk_rate);
 
-- 
2.55.0

