Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D163B7B71;
	Fri, 26 Jun 2026 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499023; cv=none; b=eM+pULmno7Mz6vWUjNj7rd9QeM9qzVP4wQeShfcTjPmu/L9+6v2Ognye3DPDiPkjD/l+brzp4OTUAP2k9MgcMLsSm6ivNeuZLfbMUT3GsT3Edzm+rZ0gO5hECTbuTm0a+85qZ5GRknaJIhfFxLw757BC4UkqHWk3+/4kU0UU05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499023; c=relaxed/simple;
	bh=W7anXgt6ShndsS8j9Eatpll4oXN6f9z6XZ2vKuQ3Hfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGAt2HgIxdGkkQ8VGvESOb1cZ+CuMya03Bd1NOES19L53N5Ur/OwvT+ffzyDtYTqVslTVHpHjIH4Ifw8FLedwvHmqrvAw+xz0z7nStt/X7GrKfsy/AjAQi+g9FiE1iv4MeflAlSPtuSDvA3GUowOblsV6hhuWO4lIKIABEB8WF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsWIRQpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsWIRQpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8EC1F000E9;
	Fri, 26 Jun 2026 18:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499021;
	bh=OucBYBkRxDTmORV5wKRKnI3Arj/SWZDC4DcjOFwYK78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NsWIRQpFAtq9jd1nP6FRJPyXaa6z5ho/a5RVcC+fGpZC0NtesuFeajEI4sOLn6x1z
	 Zo8VMH5qXG0trUI7wOX69VP7bJLv/vQntzTS7B1W81rquKREUh011F4tX3l+H8M5bH
	 6qB7ItTL4ikQma2kXmiGi50M/jZOkXnDIFZtnDarKaSTU1Gzmyo0z85cltIWG06UzC
	 Fm8xqI1YwKl0CeO+m62sDo9RAr4XZsGPKKE7QJUoVNjGwZK55Ts3LE1Oj40tn5Lx8p
	 Uld3ZwRCKvr7/WM5DpUoAkBW9+HbURQHP1wDWviXB7C5nrVcfAS3hbhBfsrCg2tu4B
	 xUKZW1OULpGAQ==
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
Subject: [PATCH v4 4/7] rust: auxiliary: sample: demonstrate ForLt with invariant Mutex type
Date: Fri, 26 Jun 2026 20:36:11 +0200
Message-ID: <20260626183630.2585057-5-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626183630.2585057-1-dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
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

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
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

