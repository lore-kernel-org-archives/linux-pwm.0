Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A22B51EE1A;
	Tue, 22 Sep 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077133; cv=none; b=pzE6OZ9lw4oCxOIKjs/40wMuxe4wKi9wducGa1RA3XEHGmWbbKxcLxqCLbHHLUV3HrTHyr3+MIAalYBIf96C80XYNXJqtUB67i+9DflbgYXeOxUb8tz1WVwhkeDqfFYNJ9w4hTbihR1PuE8HyyWQWk7lEYOvSUVkLNGZNSeeaHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077133; c=relaxed/simple;
	bh=iuoN4GiNIcuQmidGWvT8Si3UHUw3Deme8o188ZgHvro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKGLeAJu2Yp5v58sxDzXiLrvCpAiYqFz/kO5u4+Oo2Yf4QAWHyAbMIaa1mbDFD9RVF9BPtvBRuunHXjXyemZamuU2jULb+LA9qx7Ue5Hl9X/7LQwlwl80rPnkdJ7MhDIM2OM8QKP9fEiGtz+UdQUsKxhPPXDM/SHuuSWkIiMpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2C9n58U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2C9n58U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8247F1F000FF;
	Tue, 22 Sep 2026 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077131;
	bh=PrhjRypHnHwVXTH9pv1qWC5qflsvqMd31rSWkimIfhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l2C9n58UQbABln+QDThv7nNr1KfHIhzd6GyFiXXCb5YTw+iofNxOHYS587o32wZK0
	 ZujqrTP4rzP7y9dpo5JsWxqIpI8YBhKZREjJAgsnCxfTW7eXhEFqW/jzEc4LjBU3Yq
	 wwpVjSJiBFdyBf1MXPvfJYMIsWReTqGV72oZT1HnB6A7OnZXVqOKNoWpSb20jGZIof
	 Dm9Y5+tE9WKFcIouke7nV0jagaCAsADGDLGvoHPDnBX6Lqp/WiHOTJTyTtVe4EC8HM
	 YG2VmzF3FqeVHZDTCYGxkElxktRdKIWnbY3TaxluhSjWMXJX6bXmkKPUvgtz3iEETM
	 Pu2kmW40qhaQQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Tue, 22 Sep 2026 13:38:29 +0200
Subject: [PATCH 2/2] pwm: tegra: Opt out of driver_override
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-driver-override-opt-out-v1-2-58c35ded3b83@nvidia.com>
References: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
In-Reply-To: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=treding@nvidia.com;
 h=from:subject:message-id; bh=qZZKNpZegnnBzR3Ygl3ZLJ9mIpZNjQ5QnEucS22e+04=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqsmjCBenBubfyQqHcS2WYIpXP6ac6MKUZ4+QWf
 dWZAqkrI2uJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCarJowgAKCRDdI6zXfz6z
 odbtEACMleypUgkDly0AtLiQoMcbl6ge+VJYz1btYZaKkh/QY/mL574J2Yqvgw7xzh0Z0vCJ8tX
 AZxtpXHTEk1vahnZ6v0FoM462r0PUKeyue0Y9G6rSzpi1VIRyvxhre6AKT003cMMBnJhgjUzLz+
 FBDOdJ85VkhO/xiV+h4q/AmUj5CNd4X5ZND/D5r3qe0BuewLVzpdaV4Gfw0ydyNyvJf4g3UvP6F
 CB2/f05IogDZzX5lir/7b878aIaXAf5XZji6ZYn/KbL99/gjsRifxYZptOPuvMy3S5HA56qkve4
 tn+ovoKn0pq1ecPk2whXQXuqJLgKe5b5z3QeRpt6Ew6Xdiwy3auPXAAyQz7v0ICV0btMGu0UAlf
 W5Z8hElRjNrxAvgzDn8EUEIDtXnGfpo1DSEhwZAlGAt8uhpn5+IcHQJLpDz1R1mrPaYoU1bOo6T
 q0mzh4e++ndAf/EhrszgiPMR9cUigFr6erRs8w866pTDNSQnUJQb8yxWj94y2Ng7RQq5WlpFxku
 TphsL2flxHwYVJPiAjG1+bXebxz+i3YtmRn0VNhcUiYYoQ9La4LUAk+n/D7pS1+xZp79NHXf68k
 lZWBdvnw3u6oQpooDfW/R7FlFo6AAq1ubaIATYOVaGLdEZuVcOcuhUlmIfbcuC1jvajkY7iYnkr
 e5N1o9KUtmbMdEA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

The Tegra PWM driver heavily relies on device data obtained through
device ID matching and will not work if this data is missing. Opt out of
the driver_override mechanism to prevent the driver from accidentally
being bound to a device that doesn't match a DT device ID table entry.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe120ba2d..f92680a0f13b 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -486,6 +486,7 @@ static struct platform_driver tegra_pwm_driver = {
 		.name = "tegra-pwm",
 		.of_match_table = tegra_pwm_of_match,
 		.pm = &tegra_pwm_pm_ops,
+		.disallow_override = true,
 	},
 	.probe = tegra_pwm_probe,
 	.remove = tegra_pwm_remove,

-- 
2.55.0

