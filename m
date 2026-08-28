Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5C3D566F
	for <linux-pwm@vger.kernel.org>; Fri, 28 Aug 2026 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922880; cv=none; b=bMptEMp4fWJNrQXZ2mttAJ504OUlng+D1AJPuXa4EUSqdSGTIFpjCK9Q3N6RYHuXJ0d7SGbOo7mfCjtHVYXPYqTKza1s83aDU+jmLRff5abgNEyfLImtcjscyHQ67N9AIJi44XVSigQXE+oSHQzF/yokEJ+bf7L0f+dIH6ltgRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922880; c=relaxed/simple;
	bh=D4QUybtwdaEGeFdOBILEBAa96aMUCabEn4IKFQTSTqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=YYGrkRIGHQibQxxBGIlxxnsL2/qTcsLA7MFKf2qxJ9LieNjPu7iBlpUMTN+DQWIPhit0NTEchFiD+hAWMy3gLJ/MEGMt0ZuE12GXpSfETLKOueOUpeHztjGN3snErqokCci+tfP2tBRap3s5wS0PjaHqoxVa8Q5jwIwRzG30UfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=G9WfxMU+; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G9WfxMU+"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260828131429euoutp02e6ed19de6faa73c50178f200e8539399~P_mB0j2MU2411624116euoutp02C
	for <linux-pwm@vger.kernel.org>; Fri, 28 Aug 2026 13:14:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260828131429euoutp02e6ed19de6faa73c50178f200e8539399~P_mB0j2MU2411624116euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787922869;
	bh=lwl9ZR836nXomiAuieh4El+iSMRVFsDG8HllN7ocCco=;
	h=From:To:Cc:Subject:Date:References:From;
	b=G9WfxMU+ufl7buuH3N4EZ28j7RN2elpdzcYXFBksv+UhFV54sgY8Ncl1WqPrM+Hhh
	 ReqnNU0qIB+ewC0S+rJsrLfiNBaGQ4wrqr30UeEvIMPsQ8cfAFp7lvcISp+DqLNl2s
	 /YSvcsUTMAqvak6ICW53OJtJym/LyfBIlH0X1rrs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260828131428eucas1p2cc2d9767d5ed62b8297c2cff0295226d~P_mBgz0Nf2835228352eucas1p2P;
	Fri, 28 Aug 2026 13:14:28 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260828131428eusmtip175545c44f75392432a02ffdf32bacde6~P_mA87mUu1290512905eusmtip1T;
	Fri, 28 Aug 2026 13:14:28 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd
	<sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
	<jbrunet+clk@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
	Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, =?UTF-8?q?we=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
Subject: [RFC/PATCH] clk: add lockdep_ignore_clk_prepare_lock cmdline option
Date: Fri, 28 Aug 2026 15:14:07 +0200
Message-ID: <20260828131409.962825-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260828131428eucas1p2cc2d9767d5ed62b8297c2cff0295226d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260828131428eucas1p2cc2d9767d5ed62b8297c2cff0295226d
X-EPHeader: CA
X-CMS-RootMailID: 20260828131428eucas1p2cc2d9767d5ed62b8297c2cff0295226d
References: <CGME20260828131428eucas1p2cc2d9767d5ed62b8297c2cff0295226d@eucas1p2.samsung.com>

The clock framework uses a single global re-entrant mutex, prepare_lock,
to serialize all operations on the whole clock tree. It is taken by
nearly every clk API call and it is held while calling into the clock
providers, which in turn often take their own locks or trigger runtime
PM. As a result prepare_lock sits in the middle of a large number of
lock chains and lockdep frequently reports possible circular locking
dependencies involving it.

Such reports are often not real deadlocks, but once the first one is hit
lockdep turns itself off and all subsequent locking problems - including
the ones actually being investigated - are no longer reported.

Add a "lockdep_ignore_clk_prepare_lock" kernel command line parameter,
which marks the prepare_lock class as novalidate, so lockdep skips the
dependency tracking for it and keeps validating the rest of the system.

The option is only available when CONFIG_LOCKDEP is enabled and is meant
purely as a debugging aid.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
The problems with clock framework's prepare_lock are well known and
there are machines that always report lockdep issues related to it. A
good example are Khadas VIM3/VIM3l boards, on which prepare_lock
interferes with locks used in PWM subsytem:

https://lore.kernel.org/all/adqtn6iljcguv3m3ovhltusbbf4mljzlwg73yklaudvjjtazxv@vyf5fvuzic6x/

This new cmdline option allows to hide prepare_lock related issues on
the test machines possibly enabling lockdep to catch other issues.

Best regards,
Marek Szyprowski
---
 drivers/clk/clk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fef87167a60b..a5c8c4256102 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -168,6 +168,17 @@ struct clk {
 	struct hlist_node clks_node;
 };
 
+#ifdef CONFIG_LOCKDEP
+static int __init lockdep_ignore_clk_prepare_lock_setup(char *__unused)
+{
+	lockdep_set_novalidate_class(&prepare_lock);
+	pr_warn("lockdep: ignoring prepare_lock class in clock subsystem\n");
+	return 1;
+}
+__setup("lockdep_ignore_clk_prepare_lock",
+	lockdep_ignore_clk_prepare_lock_setup);
+#endif
+
 /***           runtime pm          ***/
 static int clk_pm_runtime_get(struct clk_core *core)
 {
-- 
2.43.0

