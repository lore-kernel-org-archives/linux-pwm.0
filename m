Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D438F25C;
	Tue, 14 Jul 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030595; cv=none; b=NGr/GuLPanbU3MNOoMDDBeFvq9I4XtOdP4Y1nMuW3wkKpA1G0aN15VLxLGilIh7QdS2Wuup8LrXJWNxAgNaQ8Iwv8d/GAO4zTjbWaMsMV3d8m3NulUp/kvyeXuUS3hXLjaiaAYxKwzhfoNfNpSMRRd1rDf7C1sTr6sfHXyT5Ma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030595; c=relaxed/simple;
	bh=fj23r9gIfbeGXUEdSLW9RhxkzUDooevksRNwnYq2aUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFyEPYvVmKbW2f48vpDmoqAH7XjPafikG1fDIPtkeFy4StNI27u9f4POgr+6nVm+Wx6l2p3xZrUSGTKsnL3YibAgXqoAz80b7/E7ps62A14XDf/DgGHd5UKFXF5tfaJV87VWRw0r0zCO8RfCBqHkxNXbK1g1QZVQDZ3ddbBKoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBWRiRGq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBWRiRGq"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4A9691F00A3D;
	Tue, 14 Jul 2026 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030592;
	bh=8VS6wx3pw05otFZiOirQ1wCOKDNWKVFipfZpWUEKOf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBWRiRGqW7p2h34aJRoLTKks56zHYWLYJvStErZURAXZFGwJRbI5iQlBYcUYGcWMH
	 pu6RBpUKTEbNsqoAJ1GeEXXn5kPaP5YcOfFyEORs6jkOU5tQQTYSEdBmEYdkTqfbIi
	 nGpGdBZJj4wUteD1d5tZ+BvEvdyarU6tX3zov+nMEsDHsDIMs7Q8Zbm+rws3CSItdB
	 ylCFc2u0Aqlorb76nfBIENR8qEm9fGsnBtqPiHAvnILg89tzhSDhOYwc80HN5VbzVQ
	 dikenmKaTbfrEwSSY46B5SLwfXR90xWOJZDksMKk0iCfNytOsAH07/fGyEtIV8jJJP
	 E8uNpnVPplKBA==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 5/6] pwm: tegra: Simplify using devm_pwmchip_add()
Date: Tue, 14 Jul 2026 14:02:39 +0200
Message-ID:  <35d681bb988de9eb14c6e3e0b6d3cde7a0d6ef08.1784030076.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784030076.git.ukleinek@kernel.org>
References: <cover.1784030076.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=ukleinek@kernel.org; h=from:subject:message-id; bh=fj23r9gIfbeGXUEdSLW9RhxkzUDooevksRNwnYq2aUU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqViVo8TovuoJ+zTTsuYpCiJ7t/MUFEK9aHDy+C EavZH717/2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalYlaAAKCRCPgPtYfRL+ TqgSB/0aWt6yIo/pbgxM82Hyp5rYhmrSjziKfmhH0EMmfaQ483UmiiPy4AvfsLaOt6mrl7bbLuQ U4d3oGgkRt7PK1TUFic4VVTk7+3RJsliqnXbn3a+e3Dzx/PQa3ztGGxoqUivMXUzwhUFa+UJ1wH vHVQzjn6iYpfRPBUciSQMH6Iq1xtA34DIoGYYGHKk3LFn9GOD7psMJupsP5xu+NsD6oMvgOj0xE pL5PurjfgoHn8ffsSDrRXHb5F+c4SZtGbMxAy09pPzEV6xIl54Gh+mi4mMj3RfdPZDAay2FgI6l ZBKOy6G40gvRNdkiqpyw4MusX1pcb+njE/e9TecVfz0w+hd+
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

devm_pwmchip_add() makes the device core cope for calling
pwmchip_remove() at unbind time. This way the remove callback becomes
empty and can be dropped.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/pwm/pwm-tegra.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index d7f4baa4cd9b..8e5e7e37f4ff 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -399,7 +399,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	chip->ops = &tegra_pwm_ops;
 
-	ret = pwmchip_add(chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
 		goto put_pm;
@@ -413,13 +413,6 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void tegra_pwm_remove(struct platform_device *pdev)
-{
-	struct pwm_chip *chip = platform_get_drvdata(pdev);
-
-	pwmchip_remove(chip);
-}
-
 static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
 {
 	struct pwm_chip *chip = dev_get_drvdata(dev);
@@ -497,7 +490,6 @@ static struct platform_driver tegra_pwm_driver = {
 		.pm = &tegra_pwm_pm_ops,
 	},
 	.probe = tegra_pwm_probe,
-	.remove = tegra_pwm_remove,
 };
 
 module_platform_driver(tegra_pwm_driver);
-- 
2.55.0.11.g153666a7d9bb

