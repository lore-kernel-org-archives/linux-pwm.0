Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807852FD68B;
	Wed,  3 Jun 2026 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449049; cv=none; b=pCHiKl9IA2mgR/NMatogYB9NLPI03AZWz5UjhfAIUE+lXN4rynqxjbca5fhwRIMm5c3DRnsBATziwyjJJlx9HPDm2yhJ/QT/20NsAzSKkAAswqcQH/CQmJ36XUKRLSJCreOgqGBOMsDDEfXf5mVXhVKRE5gZ44bKQ1rqUa9fjUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449049; c=relaxed/simple;
	bh=uOa12PoX3h/toUlHuGr0ZVOkgaxjpTuBwy1sIBKW98A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqI60u0uHKJTo1dJX571cNdm+2AL5eK7ADK/sNyk2tzQCugydcpD0yrIdf+aOmw/a8RpCxwpg9bXMtUFJwbPDjGLHafqpcHCSyUX9b2BVkVUtOpGjo52s+9uyih283hJqKbVmwZk6tcbvfrlsoVcR9zJotF6qPxb5FcbgMecLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrzbnswS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrzbnswS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C271F00893;
	Wed,  3 Jun 2026 01:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780449048;
	bh=t78Uhk4IqBOMxFqpBa9dZMpGO+12MHy37WkLBCfMbCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LrzbnswS35CLnBgv/FKPUjgo4RR20EobtK/uEFXX8xrbQ73zE+975zrFU6XwmD91T
	 rvQitUoffo8Mvrk4RdKhHznWi5Dsd4yWYSccwAz6MRNUiY5c+J5XEDEAtTn8ousjxJ
	 ubCGLdQvUm0u4+N3YRIJbevc0ipDdFUKDhRc+/WxPhgli5jBWBqXpSYQZYokFQfuSF
	 mEdwi5yIpihSER8bwDBoQx68V82nThwV4dY9Sj7dhxVk1Ae8LzvkgR7CNUxto7dLFf
	 j2x/o1U91nNV/sL9l8mHmNGrWEHmyWeXgunu77hQH8UP5V0Fxbuede5SMbO5K+zGuZ
	 TOeYzjix7dFug==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	ecourtney@nvidia.com,
	m.wilczynski@samsung.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	daniel.almeida@collabora.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 4/7] rust: auxiliary: sample: demonstrate ForLt with invariant Mutex type
Date: Wed,  3 Jun 2026 03:10:15 +0200
Message-ID: <20260603011020.2073650-5-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603011020.2073650-1-dakr@kernel.org>
References: <20260603011020.2073650-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the auxiliary driver sample to demonstrate both access patterns:

  - registration_data() with CovariantForLt!(Data<'_>) for the covariant
    data type that holds a plain &'bound reference.

  - registration_data_with() with ForLt!(MutexData<'_>) for an invariant
    data type that wraps a Mutex<&'bound Device>. Since Mutex<T> is
    invariant over T, MutexData cannot implement CovariantForLt and must
    use the closure-based accessor.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 94 +++++++++++++++++++--------
 1 file changed, 68 insertions(+), 26 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 92ee6a6d348e..e441ae81fa2c 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -11,14 +11,21 @@
         Core, //
     },
     driver,
+    new_mutex,
     pci,
     prelude::*,
-    types::CovariantForLt,
+    sync::Mutex,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    },
     InPlaceModule, //
 };
 
 const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 const AUXILIARY_NAME: &CStr = c"auxiliary";
+const COVARIANT_DEV_ID: u32 = 0;
+const INVARIANT_DEV_ID: u32 = 1;
 
 struct AuxiliaryDriver;
 
@@ -56,12 +63,26 @@ struct Data<'bound> {
     parent: &'bound pci::Device<Bound>,
 }
 
+/// Registration data with interior mutability.
+///
+/// `Mutex<&'bound T>` is invariant over `'bound`, so this type cannot implement
+/// [`CovariantForLt`](trait@CovariantForLt). Access must go through the closure-based
+/// [`auxiliary::Device::registration_data_with()`].
+#[pin_data]
+struct MutexData<'bound> {
+    #[pin]
+    parent: Mutex<&'bound pci::Device<Bound>>,
+    index: u32,
+}
+
 struct ParentDriver;
 
 #[allow(clippy::type_complexity)]
+#[pin_data]
 struct ParentData<'bound> {
     _reg0: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
-    _reg1: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
+    #[pin]
+    _reg1: auxiliary::Registration<'bound, ForLt!(MutexData<'_>)>,
 }
 
 kernel::pci_device_table!(
@@ -81,17 +102,17 @@ fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        Ok(ParentData {
+        try_pin_init!(ParentData {
             // SAFETY: `ParentData` is the driver's private data, which is dropped when the
             // device is unbound; i.e. `mem::forget()` is never called on it.
             _reg0: unsafe {
                 auxiliary::Registration::new_with_lt(
                     pdev.as_ref(),
                     AUXILIARY_NAME,
-                    0,
+                    COVARIANT_DEV_ID,
                     MODULE_NAME,
                     Data {
-                        index: 0,
+                        index: COVARIANT_DEV_ID,
                         parent: pdev,
                     },
                 )?
@@ -101,12 +122,16 @@ fn probe<'bound>(
                 auxiliary::Registration::new_with_lt(
                     pdev.as_ref(),
                     AUXILIARY_NAME,
-                    1,
+                    INVARIANT_DEV_ID,
                     MODULE_NAME,
-                    Data {
-                        index: 1,
-                        parent: pdev,
-                    },
+                    pin_init!(MutexData {
+                        parent <- {
+                            let pdev: &pci::Device<Bound> = pdev;
+
+                            new_mutex!(pdev)
+                        },
+                        index: INVARIANT_DEV_ID,
+                    }),
                 )?
             },
         })
@@ -115,22 +140,39 @@ fn probe<'bound>(
 
 impl ParentDriver {
     fn connect(adev: &auxiliary::Device<Bound>) -> Result {
-        let data = adev.registration_data::<CovariantForLt!(Data<'_>)>()?;
-        let pdev = data.parent;
-
-        dev_info!(
-            pdev,
-            "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
-            adev.id(),
-            pdev.vendor_id(),
-            pdev.device_id()
-        );
-
-        dev_info!(
-            pdev,
-            "Connected to auxiliary device with index {}.\n",
-            data.index
-        );
+        match adev.id() {
+            // CovariantForLt types can use the direct-reference accessor.
+            COVARIANT_DEV_ID => {
+                let data = adev.registration_data::<CovariantForLt!(Data<'_>)>()?;
+                let pdev = data.parent;
+
+                dev_info!(
+                    pdev,
+                    "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
+                    adev.id(),
+                    pdev.vendor_id(),
+                    pdev.device_id()
+                );
+
+                dev_info!(
+                    pdev,
+                    "Connected to auxiliary device with index {}.\n",
+                    data.index
+                );
+            }
+            // Invariant ForLt types (e.g. containing a Mutex) require the closure-based accessor.
+            INVARIANT_DEV_ID => {
+                adev.registration_data_with::<ForLt!(MutexData<'_>), _>(|data| {
+                    let pdev = *data.parent.lock();
+                    dev_info!(
+                        pdev,
+                        "Connected to auxiliary device with index {} (via Mutex).\n",
+                        data.index
+                    );
+                })?;
+            }
+            _ => return Err(EINVAL),
+        }
 
         Ok(())
     }
-- 
2.54.0

