Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DB37B3FD;
	Wed, 14 Oct 2026 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948051; cv=none; b=TS39alZtReq66Du/CNH1Qc+/zhMc2Ce9Fe/30pfHoqttCt8M4ZyWIKEds+WecsP5lOYFse+Fo3FulyJM2WhnIrfaX9fhYm9UbtO2JTfZ2ZI/wGzV9uwY3hOrlkdzV1TukjjgTSk/vaX9bzLaB3mISfmmVsHlkMU6M9d5c9uaDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948051; c=relaxed/simple;
	bh=GLP7c1jvsYlQSVFvqNlMXgXv+KZ9cfpP9HcNK8bbzY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4r8b91wvQfn5ASma5cgVrxLPEnaNgW8cDj/gXN55mps65pv4QS4LYMpO2ZxQUrlkPHnmjMK7bJCUHVN72y4scunI5mE0u1OumDYWrfxnM+zwU0pM5XqmyUhozqSD8UoTpydD8S1n+s+nJLAWZxdJYR5xliMS3ly2k3raU2bDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Se6qCosL; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Se6qCosL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=k0
	52NmP+3PPF6X6o0KoL7Wni7ss+tZlOufxraE07Q2E=; b=Se6qCosLx7G6MrecCM
	3Zboj3pXqGRjXhA/P/K0l4+p37l7LLFmxR6a0gUzLGbyO31Zz/L8kqe80FDLLXve
	xq+GNa0rK4EK+xk9oDSSlsV4Xhi0o+oPmzcVh+jBYWiyUJyaW7uXf6BFmpP2Ez5v
	TK6J/TXWr0EHETIqPJCPT+0xQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnFUX99M5qj_nzEQ--.33732S2;
	Wed, 14 Oct 2026 11:20:29 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Pengpeng Hou <hppiscas@163.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: tegra: check reset deassertion status
Date: Wed, 14 Oct 2026 11:20:27 +0800
Message-ID: <20261014032027.9508-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnFUX99M5qj_nzEQ--.33732S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryDXF18XF43Ar43ArWfuFg_yoW8Xw47pF
	ZrGry7AryxKF4rtF42vFn5ZFyrWw4aqrW7G3yrt3yUZr4jya47Xr1Yg3WUXFWqkr92kay7
	tr4SyF109F4UZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRv388UUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7R7Kk2rO9P6EwQAA3B

Check reset_control_deassert() before registering the PWM chip and
use the existing runtime-PM cleanup path if it reports an error.

This is an API-consistency change, not a claim of an observed failure on
supported Tegra systems. Keep the existing reset assertion before PM
teardown in remove and the pwmchip_add() failure path.

The issue was found by our static-analysis tool and manually reviewed.

Acked-by: Thierry Reding <treding@nvidia.com>
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
- drop Fixes and stable-backport implications, as Thierry requested
- retain the small status check and Thierry's Acked-by
- keep explicit reset ownership: moving assert to devres would put it
  after the driver's PM teardown, rather than preserve the existing order

Previous version:
https://lore.kernel.org/all/20260830125843.99132-1-pengpeng@iscas.ac.cn/

 drivers/pwm/pwm-tegra.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe120ba2d8dafd81ea5520f1a637827d8eecf..d9fa16a7b31f43bd9d75474f851899956159d836 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -379,7 +379,9 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		goto put_pm;
 	}
 
-	reset_control_deassert(pc->rst);
+	ret = reset_control_deassert(pc->rst);
+	if (ret)
+		goto put_pm;
 
 	chip->ops = &tegra_pwm_ops;
 

base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef

