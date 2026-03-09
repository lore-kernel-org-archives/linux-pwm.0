Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5E36A003
	for <linux-pwm@vger.kernel.org>; Mon,  9 Mar 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773087608; cv=none; b=OSw/uw/1uJupqC5zfI8o8LCVVxDuqYqXlp/PEIlp7ziPL8EoF8nzmT6ckMTThacdsxhteiqZjnGqcjqWjrbf5cG+EDDEgXXqqvB52ZyftlQR/Gos8eQHG8qLxWXZGNrF7Ftuj3QGkABw9rA63zKgvxUbuQd+FSBdeG/ougZ/mVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773087608; c=relaxed/simple;
	bh=bM/9IOi5eHY0KX/YhQMQPbzGb/9QrTHmaaBG9rkqPxQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=isjMGwcE+VDqjD7EPcSfdsj8q5fPSjrxsaS/MTznOiZsH8rGFdDXK29fQeyNGxmaDdari0zfah5du9txZWRAq1ZbajEjzHjJ+jHXUqJK90pj6cTgdGu/0ev2c+xwwhOqWAGXthnqRcdugEXI3JqwGQTWAZvrVd52LXvRZwQbzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul372W7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul372W7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377CFC4CEF7;
	Mon,  9 Mar 2026 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773087607;
	bh=bM/9IOi5eHY0KX/YhQMQPbzGb/9QrTHmaaBG9rkqPxQ=;
	h=From:To:Subject:Date:From;
	b=Ul372W7HDff8uX89wXbcRHIwo6Mld7Bwu5xVj0lVcmIkEXvQFC02bscGSLb7LDpNa
	 dVdBmvm9uL3dm2Met4j6dr8qAg1VfHANbaib0/40oMklrJFSbAXqunIpKNlcvZ4NHU
	 gtQMAGjFLHPnBa4969ZjdOhp4jalBHJqwLJ7IEhSJ/ckrD+5OPNsqmq8xg4CSd/UDo
	 tExihz79qu6Gwb3EsMQyJHIzEjcc3eJAjD/c8eGE8ZVN82DUazFMIxcmmAmgjVwFxo
	 L0ZJ17/UhaibIgbscCHTnd30WjCWrvUvxlzZZ8Nprlk4RpOqAmkGNkBEPJS4yj0Ksr
	 c97e1MFoMESyQ==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add #linux-pwm irc channel to pwm entry
Date: Mon,  9 Mar 2026 21:19:55 +0100
Message-ID: <20260309201954.1938136-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=ukleinek@kernel.org; h=from:subject; bh=bM/9IOi5eHY0KX/YhQMQPbzGb/9QrTHmaaBG9rkqPxQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBprytqYZzRNkMIf6OJRQfibnmXl99ZGbtamXGsA Y3oMttIaU2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaa8ragAKCRCPgPtYfRL+ Tt7DCACzUlImmtD1qNLAhF133uswMyn9QweUxjLnVqMPou06mHqk7ZpLImMITLwCqw63ItZ7YBu 0wFF6brCH8UHYD4wcHBmLMQi+YWxFBdQXSXy/0GYLOHsJ3Kj/95O7QJ+3X8kzeQKtHnlj985tHl JyoRZYeNA/hVeDFRpIpYr0p8fU3PwQ7cW3Zr2PwZnn0bWjSclTgtCNFe9rWv2kCn8flF42D2tq4 cY3ycVIiCQrJhy8e0k5FuCleJEigBKR1qGFckb7kZLnFCCf/zdLKecM0XwjyTetmwhzLgZninJP 9/V0o6n1QWUn/HqvJ6qLycfDLXiVyi1M0b2qPe/nN5IjxGID
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The channel exists since quite a while, it's very low volume, so chances
are good that I see you starting a conversation.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..708c050ac397 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21337,6 +21337,7 @@ M:	Uwe Kleine-König <ukleinek@kernel.org>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
+C:	irc://irc.libera.chat/linux-pwm
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
 F:	Documentation/devicetree/bindings/pwm/
 F:	Documentation/driver-api/pwm.rst

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.47.3

