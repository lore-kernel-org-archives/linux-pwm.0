Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801210;
	b=3gsRC3wOv8et/3AvhUfcC3RbEorPgoG3oL9W0vIfQ6YzIpV2fjP7f9VjJQqlek87WIsd
	 0E6H56i7xwliWlnP5A6p2qadC48SkOWB/F8wLSm8B9RlKN2goPVjaOJRCKbaaBxYg7Kq1
	 JgMvJ+eHmh7Vl8U6qzlYFarVR0Duu4+rtL2ml5hdG0HWbBWS6KyAKZrS06EWJXVZ3qD19
	 yePAsqD1dl1xBRoC5WCCnv3vHxZFdTKg8wHqplqytIxNyQKybli68yo3xH9sdBuzF6yC/
	 nW2nR9VLfWDbZBbRi3ortH52cq3nLKANqKuee0+8Ii8YHuUaZl7qLdMYdnLePLmcTtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=GcnQpQEXEsi+nvPttlap4C/vSdbuHSCBd/6D5U5RPLw=;
	b=YNkqZQRBaL5xzn4OFUkcLgkoByCrozeZ2dvuJL/DkVh/iseUyrzMDcjV/w4XkIa04SE5
	 +uZDr2dXYStdzQBL6KFPVmG0+Z8RmNoJPcJmYOc2MxC0gqNrDhMWtum10nOHrxmvSffaF
	 wIsaXVBqxoLDbSzOMkUV9AtxoGGU1xrkzOG0K9cdtW1NRONq0Hp+k3zfPqh27sxuIaSrB
	 zJZYR33LqTpV6kms8W+B/rDz1PUFnIYz5PyUSYwjVCObkp8jrMYfnYA60ZNPNhY52f2za
	 ejDcNvhCqVmPELH2b84bASWMT3bOh2bZn4OSfehLHluiut+9oJKNJwQrqSg62baiSsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BOenXBKs;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D9606A31E
	for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 17:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 149D9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BOenXBKs
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e46e449e8so5497150f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795801208; x=1796406008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GcnQpQEXEsi+nvPttlap4C/vSdbuHSCBd/6D5U5RPLw=;
        b=BOenXBKs540CBXJYvgFslWeU2CW9MAm0ao8OraihhQpQS/IC2hasWdF33kI53UbIpT
         QHmY2Z8NWBeWtnpVakQZYnR0ycqdrPrruk288iuzx+x9b82ukdmSzIcqao9DxSoJiojF
         L2YwfIvTqr9O/GgBGSojLHXhr5TdxzT48GO6UWBUbqXVZf+ga0086EwgvXlIf4Sinycw
         R22/BDvEpddDu326sCpNtPIuifkyQAmMktB/Za1s5PkohI/amI+Lvhn6pCqGM/RRJEQL
         YE+/xqPhgcA+iVTe8fjAyGM6hr3yalLiDCruDKJuYxmxeuZ2Og69p3b8O1cD45mTyq5o
         0puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801208; x=1796406008;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GcnQpQEXEsi+nvPttlap4C/vSdbuHSCBd/6D5U5RPLw=;
        b=eLDCXT3cjWdGm63vLDgiboJ7WpJvD4EKNlNsR+yzBbkj9TQ08C5AEk5P/x1Wmv17LS
         wQgLnERFCSeT0h30B+OSBnKcZdTnQSg89C347lWe2YDrD49y4WfY0xpr6H0Kpk/LgGS9
         A+Q2kSdQHFuL5XW9cyFP3zKgQNcdqAK6tDSfhdoe2ptFGT4Ok7So2R6nPxX8QqlmAx13
         26rzFQZ28PlOT7E8VrazbZtiTqqe+DKm8LDz0PNA5jdGlCXBxVR4fvfAGVli6GCznIoW
         4CGcV6nDm9aUs1U1KS1SLaNQeHQjwfdzWhS5/RF2/M2cEGUVjF4A9eVrVTOsM2P80vuw
         X0Iw==
X-Gm-Message-State: APuU4Z/AroMNWLT1hmjOBdtckz0PmqZN1/30zC3evxqVaanXS51iNS40
	m9KXmuHB7TSn3Wq5OKrhhiZDbSxQFUB2ZB63QQlFWwS7OFm/zIOi2lotGHpB5s5W30fx1+JKLyx
	SQBrhXk0=
X-Gm-Gg: AZFdTZe/KINhjuoDqfYihhvT3umGZKBuxU6RHElbkwt0RWDN4A25I+Cc4cVgcAu8ZmO
	6jkGEVYJ651YmQBlkpyMm2EaSGFPHWps9anHV+o5WiVo1PGrVyeRh2G3Toow2Ux8/dYQ9lQxJ1y
	80DNthXbM4o3DlrtUiwV2cGTQxmpcV3PhRtgHb/l5L9/DXU7dwpOX9ro5wgARElrof9Uj//XT1m
	E+MxmMLGl6tZewbrODCaCNNRVEFMbR7vAyKipLlfiHY9NzcjoZ46W/oxAMb+Rq5Sc6T8FdI07x3
	vhDess2Ki0MpujGM5F21jV+1Ccg1U6VxjUmjY5qLhqbRwicPwzm5A7MNSROYbJ2F3nFhL5mt3m9
	Dc/VmD+G+kh9ITArw5PnUJtS1pl8L/NHTJ+J6pmfTFQrEoN8pcZUpZiAxhHq8KL/zTzEdN4zTHo
	ZP3v7akQa2E+XV8M0xj2ryIJ2W94c7Hwgrm488DdyRttqfTWiNYWweeKcWddqhjiXt5/WU7oGkX
	MQDRFLbUW4kV3mEyaZPzePW+S7hr8ZI2D/OnGRgskZyMa05c3SQaBllmOlCTCvhDpXXEEhxmN5n
	95QIgv4QfbPW3hbnF3r+oRvtczpIf1qzExgydU6kNivUTkRrPuym8w7G+mTIFWrKAyDgBtWhB/z
	8V2tCnlK+Q+odvDzf
X-Received: by 2002:a05:6000:4381:b0:4a7:e4c7:2795 with SMTP id ffacd0b85a97d-4bb965c79f4mr15672379f8f.36.1795801208451;
        Fri, 27 Nov 2026 09:40:08 -0800 (PST)
Received: from localhost (p200300f65f044d0890ab5f15b7da13fe.dip0.t-ipconnect.de. [2003:f6:5f04:4d08:90ab:5f15:b7da:13fe])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab658e2e6dsm46652250f8f.6.2026.11.27.09.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:40:08 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: =?utf-8?q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] pwm: tiecap: Assorted fixes and improvements
Date: Fri, 27 Nov 2026 18:39:39 +0100
Message-ID: <cover.1795800756.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=lwyyQjPMflqKxy+krxkobamP71JzUQng4Ev8FJqpSxo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrCcBbkdh7+Yic6qPU0TvIds2uMs5cGqaF1NkrA NWPlw3v2QmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawnAWwAKCRCPgPtYfRL+ TuixCACwtmwXDO2XbgeKmsVM294Aq4eyxfizgUsLoRfQF7uvH+/OROd3y7rkflkR6ddZy0MFJog u8q7ymSB9YC6LUizGhKaFi/PX0ht/OAJmeOmF4RfZBPaLZRziC861ghAem49UMsfbJmrfvCthz2 uAn8DDdAlfyfwc7s7GoRglNPASzFBKIaJhjaZnF8dmL5Z3M4H7jpS2X3zxzdAHBngD0+L6A0DZD KClKdqA/GU2/2k9XCLuIuD27e8ecRtXmxP7v3MwN6r0INbdOniGrajdwFrrl4HYHaj5abS6MBm9 b8tM9zxUdRZccQZMGGodnIuQ/gg+noqsfIJRfwZjvQPVQ/vQ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

while looking into the driver for the review of
https://lore.kernel.org/linux-pwm/20261116142251.1296742-1-maximpedraza@gmail.com/
I discovered the patch opportunies taken in this series.

I didn't mark the 2nd patch as a fix as it might result in power
regressions during suspend as the clock is kept enabled there. So it
would be awesome if someone with the hardware could test that.

Best regards
Uwe

Uwe Kleine-König (5):
  pwm: tiecap: Fix type of variable holding clock rate
  pwm: tiecap: Ensure the input clock is enabled
  pwm: tiecap: Use dev_err_probe() for error handling in .probe()
  pwm: tiecap: Make sure the input clock doesn't change rate
  pwm: tiecap: Improve period calculation around overflow handling

 drivers/pwm/pwm-tiecap.c | 94 ++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 43 deletions(-)


base-commit: 8c35f759bca417ab337f3c383be2d0a001a5ab25
-- 
2.47.3

