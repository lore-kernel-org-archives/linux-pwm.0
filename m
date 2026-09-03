Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F079B401A14;
	Thu,  3 Sep 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451593; cv=none; b=AyDb+Rc5lXBFt1zke0xz0PqEbXXCr5bYNsySjrxQkHLGqMpSw99Z9d9ZgWDwE2BADd1pw/WkaRgDZgFzAWAzc4Hfi7iIOcILTfcuoyUhVcmO56/9NYivdIiPbw0rsTeCfjfx6ul1zD9J+F8ZmqSwyCihEfF08+kBIe3x7myNcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451593; c=relaxed/simple;
	bh=Ai2ap9a83d4keCYEPJTh9detIRfttkQjt0vTbgizJkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FI0T67V1Dmd2V3zKgnviCnYl35W2LRk4ymtUKryVBZtAaJJOHFrGGZLKGS17pqyH45iLtFkAe0ZUqxSWQnn1ssFJDa00Ww2qwvOY02EW/mdY61x8AvucIqnPpzhQTN8oUI6+HasNVY/Xk5W63jdG8H9ifwP7qfDOwsC343XUb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZRcBM7xp; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=avMzyxD6; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZRcBM7xp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="avMzyxD6"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbPbn5X2XzMlDx;
	Thu, 03 Sep 2026 18:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788451589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gg2sB7B66/jeFbIOg24cesubA/VpUilLGcsL8f6dKtQ=;
	b=ZRcBM7xpqAJ+8JJrTcMY4131sAKddADisme8ZDPK5Hu0NKOPZ2S9aJEILcxdhCkkL0zGKZ
	wQRcDRlA6YXe78dqynSJ9Yo5NE0ywX/mziz+SBRqP8i7RDCEKCKrFvmaHHhHFDkxVBTsRK
	BVThDC18D8AFoPegFjYTgC3XlFYlqFNdG7+nxNKpCu/beWEIOOqnLCmRxdOwhMo/FOMmFU
	57j8ok9t3tdlMhkGGP7+YVrcf+JIc0n1GEpagGJQ9Xnpwo1XvCsQSzM9L9pdMjqk1BSdnR
	wRruwD5J2vsj0E1vXJoBXZo9KRBbsMuXsI0hr5BMYn/E7Iiqm94YtO+ukUVM7Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=avMzyxD6;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788451588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gg2sB7B66/jeFbIOg24cesubA/VpUilLGcsL8f6dKtQ=;
	b=avMzyxD6JmsYEo52J2JDgatD9a3ymC1GiVfWcflw0srTWhvsgCXK6/rIdX+YNCX5wNS7lY
	ovOgk5fM6d3Y8JlYdu544lPc2FlFCtM3eJb8sZ8ISNK+U9kJ91hrlfgpuScS1BGZPSgOMb
	lluMDxzE8rs8CLl095IkreHcZ5pSxc8TyyOiLkJMRLx/MJOEGRpuMi0o/MN0Pvrkqtofpz
	e9+e8THid+vIRzIooNDQYsKYuWq8vsdH+uTdsZqQmlEQWluZB3ANPUqSHdSCvMGGSct4LH
	JOEATlZznGqe/NLVdLAiIg8mQ9ki/QxrCi3neiu7VSCwOEKrJ1f2SsLluWIGtw==
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-pwm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: pwm: Remove bracket
Date: Thu,  3 Sep 2026 18:05:35 +0200
Message-ID: <20260903160535.734369-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 563xyn3y98dh3fffojxi1eq9mrk6mqyd
X-MBO-RS-ID: 0606344c0f863c1eae9
X-Rspamd-Queue-Id: 4hbPbn5X2XzMlDx

Remove needless '(' from sentence.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/driver-api/pwm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 0d27a40f5..d62e3a695 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -177,7 +177,7 @@ and pwm_put() may not be called from an atomic context.
 Most functions in the PWM consumer API might sleep and so must not be called
 from atomic context. The notable exception is pwm_apply_atomic() which has the
 same semantics as pwm_apply_might_sleep() but can be called from atomic context.
-(The price for that is that it doesn't work for all PWM devices, use
+The price for that is that it doesn't work for all PWM devices, use
 pwm_might_sleep() to check if a given PWM supports atomic operation.
 
 Locking in the PWM core ensures that callbacks related to a single chip are
-- 
2.54.0

