Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE95535FAC;
	Tue, 22 Sep 2026 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077130; cv=none; b=C7762DTCgf2mAnYznQ9Qv06Ffh78kBCfTuOtumSnYxrdmS/vd4GfV8cgcrzfEn5KBIyGlVoSYNfGKxxq7LrRNgS4LwjTTcqrptXYY+ATkT8JRI3H44mtZ3hyBsGtzoqySt2zTsD7i2Xhambk37CV/3qMVMBubbXyOAOQPBl3Ues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077130; c=relaxed/simple;
	bh=5n9pWbiHAH8P8YiJvCH1EdJKSYbCvVsLjk1Q11/ZNLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QABdbfI7WbWHnbY/0pYxZmJCk7KcCjMwwTGfKKTLneQmEActGBAmZlQWWci1wxZG5SxnNWNeqYSJ3tmrxtmt3ZK0D332me3/lDOI6TpNQRhAfC5/O0vptKVQapz10CcRe/SVtHWjxzvEhb2jHCX5xCRtj8zVg4vlknsLG+C6ThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8c8Ctzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8c8Ctzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38011F000FF;
	Tue, 22 Sep 2026 11:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077128;
	bh=E4fYdW5550uqlFQXYO/zI6JHUmrR1Jj/fmv8nznqlVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k8c8CtzbyyZfono6DR2zQtLVqvGH/SkPv3nSqHDtUXzXrvAZTUHPSrxx1z6aNKk40
	 1wOPW+y7n4hMydsacKSO5VUL/2Ej1hoqGL6jO/tuN9nZl0ZPDtzlYmDHq9Xer79RRP
	 5ADikRhA2MYOSzBN5oifwszMHktpEW+RNhgWWv0jRfStgLVvwowVWPs1TGTKwKOjDs
	 FlINXAmTLC3lhH4SugsFmDIbOVczJbpPVm2b+xVKZa4llYNKQyd9cc5orcJDKDyoRm
	 K3HIUQ4Qtgb7LKHHZgMaxicEqpvfesN/fS28OfBYCouBQwxV+cf4YRtHDycHAo117d
	 OS9GGKFbrGB/g==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Tue, 22 Sep 2026 13:38:28 +0200
Subject: [PATCH 1/2] driver: core: Allow drivers to opt out of
 driver_override
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260922-driver-override-opt-out-v1-1-58c35ded3b83@nvidia.com>
References: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
In-Reply-To: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3527; i=treding@nvidia.com;
 h=from:subject:message-id; bh=pnp4y8gOI8NPE+kT7OmWydPxWN5jd8mwpDt64ZhEv0k=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqsmjCrKM/9dnqL6gziIvrnCtc2FBLeu73P2zk2
 //+wXnwIJmJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCarJowgAKCRDdI6zXfz6z
 oXVVD/9frCnDMue/Uh+mT+vFzE0UlvVV/CDAkgLkDw0aWRl878PNk6tznrhMNI+sJM7dLGCJ1dS
 3SB4bXgL2Nsfh647dHNlY8PwFjDzfL8hSwgPLyawcq0hEiZOLRzlxetlFmqCoJi0+btKKTog9mc
 bOYY+f0OXp0glP0wCXySj8Ji+2j9J4YUcanFb0gqK8oYpVZPRJ13PVcPuGaRo+y9NiOVbWzML0A
 AiWsvmKpyPCHTZCrmoCmz7CfSVhIgytKpdVnBSzS2hfAW1mM+KESRgbUGtO6bxNYSfeTKnrB8JS
 8XDQ21ZjpdJqT7XmRy5Jp0AyGWP3kER2KZEsG4YVVClJ9C79T3WR4W40aEpLRpiiOkNp1vc7v5x
 BhQVaXr+KC9EwJoHOXbZWEc8u/6OJm4i3cHXnSYiy6hnFsSux/FDaT802YvCgKuL1lhFYT+utJ7
 SK+jWhElZZV5uubhnEIqzEejsgvacUVrqPNTlRL1aufX+qyDqJE+S7qRy7EYZ+JOoLMJiC+00k/
 CLHvaiocFv9FTPDSxMQwSZlZC6nU8ZQLyCqVn1lYRFlpwqt1GZAS9qAeh2BwJu+j2cjAMda7Qsv
 +IoZYoYRkqJ6QG2U6sOw9gROeZdbQWuRO7yvBzk1sFrcMUBgsS7V39u8ZGFhYRYi/VozMfVeD1r
 dUARfFpOq1KP9Yw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Some drivers rely on device data obtained through device ID matching and
will not work otherwise. Some such drivers don't check for the validity
of the device data because it is never NULL when the device is matched
against the device ID table.

However, Uwe recently pointed out that drivers always need to check this
device data because any device can be forced to bind against a driver if
their driver_override sysfs attribute is set and the driver rebound. Any
such device will now not have device data from a device ID match table
and may crash.

Add a flag that allows drivers to opt out of the override mechanism when
it doesn't make sense. This allows us to deal with these situations in
the core rather than sprinkle checks throughout all of these drivers to
check for validity of the device data.

Cc: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/device.h        | 12 +++++++++---
 include/linux/device/driver.h | 12 ++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 90cdd77458bb..45c23cc5efa8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -899,14 +899,20 @@ static inline bool device_has_driver_override(struct device *dev)
  *
  * Returns > 0 if a driver override is set and matches the given driver, 0 if a
  * driver override is set but does not match, or < 0 if a driver override is not
- * set at all.
+ * set at all or the driver opts out of the override mechanism.
  */
 static inline int device_match_driver_override(struct device *dev,
 					       const struct device_driver *drv)
 {
 	guard(spinlock)(&dev->driver_override.lock);
-	if (dev->driver_override.name)
-		return !strcmp(dev->driver_override.name, drv->name);
+	if (dev->driver_override.name) {
+		if (strcmp(dev->driver_override.name, drv->name) != 0)
+			return 0;
+
+		if (driver_allow_override(drv))
+			return 1;
+	}
+
 	return -1;
 }
 
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 29fbc01ef06f..c985622a67a5 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -57,6 +57,8 @@ enum probe_type {
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
+ * @disallow_override: Prevents the driver from being bound to a device via
+ *		driver_override.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
@@ -105,6 +107,7 @@ struct device_driver {
 	const char		*mod_name;	/* used for built-in modules */
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool disallow_override;
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
@@ -249,6 +252,15 @@ void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 void driver_init(void);
 
+static inline bool driver_allow_override(const struct device_driver *drv)
+{
+	if (drv->disallow_override)
+		pr_err("driver '%s' cannot be bound to via override\n",
+		       drv->name);
+
+	return !drv->disallow_override;
+}
+
 /**
  * module_driver() - Helper macro for drivers that don't do anything
  * special in module init/exit. This eliminates a lot of boilerplate.

-- 
2.55.0

