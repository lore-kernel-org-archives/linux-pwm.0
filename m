Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981254;
	b=3jW25oQvHgfubDUBEwXWKiXDT3HE0nAEab+lnWA0cTiR+YEdyAGyadYK6sBQp21jvRJ6
	 L5vPI0VYjTD92i8yhymBDoihKoi2NgIgXLC+C/bxjKRAoh68Yzr/0ugjBLoCppZcK3A6t
	 YT2dJapzOID+uQp3qlGxscDjXPjjfJFWZcNjLVAIRP9Nq0OVkYmuAL5tsnjfnD4EubsbM
	 gp1ET2ssI7Dd2jdQ+7naSt5dm62rVEHqi5LRkkhw90o7/vulBHrEdqmxqzbj3gJrQeyD3
	 uFmJg+f6/eznS0Hj9TvRNG1sol8DRN5QlRI9h+cSji4AifQ65NqgjepVe+D2ogm51sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981254;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=s81Qxk279B3OZvT8HyIcxZsvmqYvi7yEZFqL8sa0/fc=;
	b=jRADENuSmugdd2uzEcDbQs+PjZWszPLXQDWIIohctjMPEawgi1wsk1Jajx6XQWnr9Q61
	 tD61CQ6WKnKZE0XQVb/xTNsIasaUbDHGq3mCLuHss59KqmtrlRea7LsSK3kH/9gXiyksL
	 HAr564Hf+3qqV7TwLyrCazKfb3H+JOa4uv+dSYDHcxFcT0zW/Q4Z0+jjh0S3iDCamFdo0
	 pdQ1kDwifu9L7BgTA/oSgIin8X1usRX0nVWy5UQhzi6TktF4I+gLrnq2UIOLQrTkczGbI
	 9A11T5m4IOwZvthH/gHMTocE9QstCOnammHZyeSkDl4MGdtjBXJJa3UHTHu4awroDmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4066606A326;
	Fri,  6 Nov 2026 16:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4066606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLkbR68lnz8Xrrd;
	Sat, 07 Nov 2026 00:07:31 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A6G7LSP074678;
	Sat, 7 Nov 2026 00:07:21 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:07:24 +0800 (CST)
X-Zmail-TransId: 2af96aedfb3c6af-a8634
X-Mailer: Zmail v1.0
Message-ID: <20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn>
Date: Sat, 7 Nov 2026 00:07:24 +0800 (CST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>
Cc: <laurent.pinchart@ideasonboard.com>, <heiko@sntech.de>,
        <ben.dooks@codethink.co.uk>, <benjamin.larsson@genexis.eu>,
        <nuno.sa@analog.com>, <xiaoning.wang@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: =?UTF-8?B?W1BBVENIIDAvNV0gcHdtOiBmaXggb3ZlcmZsb3csIHRydW5jYXRpb24gYW5kIGVycm9yLXBhdGggcmVmZXJlbmNlIGxlYWtz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6G7LSP074678
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 00:07:31 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFB43.004/4jLkbR68lnz8Xrrd

Five independent defects in four PWM drivers, found while reviewing
linux-next next-20261030.  Two are 32-bit overflows that make the
hardware readback report a wrong period or duty cycle, one is a 16-bit
truncation of the on/off counters, and two are missing clock or
runtime-PM cleanups on error paths.  All are reachable from the PWM
sysfs interface or from the hardware readback path.

The series is ordered by impact and is independent patch-by-patch; each
patch applies on its own and taking a subset is fine.  Patches 1 and 4
both touch pwm-dwc-core.c but different callbacks (dwc_pwm_get_state()
and dwc_pwm_apply()), so they can be applied separately.

  1/5 pwm: dwc: Fix 32 bit overflow when computing duty/period in get_state
  2/5 pwm: airoha: Fix 32 bit overflow when converting duty ticks to ns
  3/5 pwm: adp5585: Clamp on/off counters to the 16 bit register range
  4/5 pwm: dwc: Balance the runtime PM reference when configuring fails
  5/5 pwm: rockchip: Fix pclk leak in get_state error path

Shao Mingyin (5):
  pwm: dwc: Fix 32 bit overflow when computing duty/period in get_state
  pwm: airoha: Fix 32 bit overflow when converting duty ticks to ns
  pwm: adp5585: Clamp on/off counters to the 16 bit register range
  pwm: dwc: Balance the runtime PM reference when configuring fails
  pwm: rockchip: Fix pclk leak in get_state error path

 drivers/pwm/pwm-adp5585.c  |  7 +++++++
 drivers/pwm/pwm-airoha.c   |  8 ++++----
 drivers/pwm/pwm-dwc-core.c | 12 ++++++++----
 drivers/pwm/pwm-rockchip.c |  6 +++++-
 4 files changed, 24 insertions(+), 9 deletions(-)

---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
