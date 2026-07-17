Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121CC3C3F48;
	Fri, 17 Jul 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281257; cv=none; b=IRu67t4ETcE1dHjkPQQyLuhYbMrNaZ3aU2yRiJz8nsTwnmOk+Bv87ySg0mGs5lWHVwlvbWYldTRV7Jxi9kp4D+pm9bVIpbfilmgm97RGwhEXZgS5sDOaoP/JLRP88f161LEVvSxGNDTq4Y2OF6GDLyzpYL4nunU8azzDrccHzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281257; c=relaxed/simple;
	bh=l/ei6iJha+NlkjBn+9s14A0Ck2KIIkWb3z0LLidF9D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jg1kbrbZRq0ckw2Va2ZyQvoSOfeyT8Hjvme+25KS3ZfBDs8v3fOEYZtAjytBbx4WXJJXv2mV4xCquczr1OiuHDpqpk+3pjX267Rgl7UNoCCD/qRmK6JsNH9lme+0juEfFcjbORqlaYEHU6nzNy0iVKNHl7hJbAp+z+oOrZaI0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Pm4DeM+V; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Pm4DeM+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784281249; x=1784886049; i=markus.elfring@web.de;
	bh=+RoAWrU06cvp0dYNvtPkSIaXpQOvQtLBbxOunO5iyEQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Pm4DeM+VjcBDGAvDJK/s7Vf5or/ekYga9u5LkdIFLftw1c/Kq6Y9TbvPeovtMvAA
	 3KYeTjLQvV/wcxgj0a3K7i2Mmufn/Q780rDAePMGbRIfMUxp3RaDpbiC1TaprJd1B
	 Ko/7rCtohg8HTVaojUX+mOLYdofcxuZcyA1RfYCCVAzKFRoYt76lHct1Zwp2f7eKQ
	 f5ITMqsEnqP1cmYzKFHreBH00jGo0UEXSsE62HR5tQhRhp4HK3Tst16372q674Lfg
	 wkbZFfQ/Tg60aBqZ0kGRGHDpnu9Q3p/QZVWhDqiID5h9iDz9LSMnH5pe+uzrDezzE
	 KzS2aT2hI5IgcPvFpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQGF-1wndCd3KKj-006CXM; Fri, 17
 Jul 2026 11:40:46 +0200
Message-ID: <03062fdb-cc4f-47c7-a007-4ac67ded6377@web.de>
Date: Fri, 17 Jul 2026 11:40:45 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] pwm: Use another seq_putc() call in pwm_dbg_show()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <3e9f9238-a0e4-4a29-8a5b-27e4a5a0e1e2@web.de>
 <aliLpfmKkkwlZhzF@monoceros>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aliLpfmKkkwlZhzF@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KN4+gNb2LV249yV6OruDC1H1B+x8w6yoAj3whrherZkAHiEeNqI
 5hNpU47GK4hfTgbxe4PoUUgmgOXAn1QSaIBpFxOXwp/5vlS94LfGliBitV6Y3AGiItuRW5L
 dvIDJx/fUOsnCobpS2CvJELUmahoVrvNTMzJtT0FlCweHM/DL5DwzUNEM5Q/wNEPBntuFaX
 pIm5cJJZABBIBh0RaZArQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/IossmJ0IjM=;EpCTjTn68Q5HN8zVWh2RYj8YxPV
 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
 fzsZtu7yLteL8/FrGq12o

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 17 Jul 2026 11:33:55 +0200

A single line break should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pwm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index fa0f8f1f6ed0..c2d77082c549 100644
=2D-- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2647,8 +2647,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, stru=
ct seq_file *s)
 		if (test_bit(PWMF_REQUESTED, &pwm->flags))
 			seq_puts(s, " requested");
=20
-		seq_puts(s, "\n");
-
+		seq_putc(s, '\n');
 		seq_printf(s, "  requested configuration: %3sabled, %llu/%llu ns, %s po=
larity",
 			   state.enabled ? "en" : "dis", state.duty_cycle, state.period,
 			   state.polarity ? "inverse" : "normal");
=2D-=20
2.55.0

