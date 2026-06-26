Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE53B7B71;
	Fri, 26 Jun 2026 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499034; cv=none; b=AyiZQVY50pd7Hx+V7KGQfSOaCmScxcJXeo3o9/mkIZSYPm5CrUV+qw2miPQw0q1LkMvpCOHZHqZN1ico/si/cBe92lfgFEJgj5KhD1QtNz6LHJwDCH8CqZOvW87RtAArYubmwbiECtItb2OsVT6TTUsoz6TOitYmScdzrtRKNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499034; c=relaxed/simple;
	bh=1bY71DPZENvERXkhelA2ESYi7XUBroQQuXZVvVqMMFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRXBIU9Fu5772LjfQDptw+V8h7WbFyXbThA88S1SX2gVaq4MKKDGam14mXI5GrP24te7/DiU6G7JYrGz6vfUszIJXtzCOgq+jxvEobi0dwGPyPHdpR+k6GncxykGwujD2aYWw7VwIMxulW+kU6Y7VNB6YqdCPoegSoEDDkASIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REMzAVBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REMzAVBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03011F00A3A;
	Fri, 26 Jun 2026 18:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499032;
	bh=LdNaTTk9wNNpDOVSF33kTh+EjW3VqsNef7eZ4WrstEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=REMzAVBD9Y+oXmHdfOvfnAtazgm3pDPF2DQm/fpdyrA2UK/bEnU0ZyawWhgVTsjX0
	 0mBFW6JrGflTz4eIIbGBWjafY4kGXt3YRnu05IAEV/bw7XAvxtMOksvAofxUuXB1bd
	 Bg2GWS3/t/32FjWKvvfdOl0F8EhAy0S9SyDR1NzPp61TudiXZWFGiGEO38fD8X8nxR
	 EOT2+jyTv6lAfzXAOtTkV0M6Ns0Ujyj0WwMNC2pncWaA2q+0Y+dbyuXBpYqWdY1YXx
	 mOtvYOfUgwu8L+eCkrL6DUsRfez/k8ReZU7F93EKTfLW6EAy5yHSWK+1fCOeIM2yd3
	 CHhYtrCqeYdUg==
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
Subject: [PATCH v4 6/7] rust: pci: return DevresLt from Bar::into_devres()
Date: Fri, 26 Jun 2026 20:36:13 +0200
Message-ID: <20260626183630.2585057-7-dakr@kernel.org>
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

Implement ForLt and CovariantForLt for Bar<'static, SIZE> so that
DevresLt can shorten the stored 'static lifetime back to the caller's
borrow lifetime.

CovariantForLt is sound because Bar<'a, SIZE> only holds &'a
Device<Bound>, which is covariant over 'a.

Since DevresLt::new() handles the lifetime transmutation internally,
into_devres() no longer needs an explicit transmute to Bar<'static>.

Add a DevresBar<SIZE> type alias for convenience.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs    |  1 +
 rust/kernel/pci/io.rs | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..f783b9d9fa26 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -45,6 +45,7 @@
     ConfigSpace,
     ConfigSpaceKind,
     ConfigSpaceSize,
+    DevresBar,
     Extended,
     Normal, //
 };
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0461e01aaa20..7a0d2d74129d 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -6,7 +6,7 @@
 use crate::{
     bindings,
     device,
-    devres::Devres,
+    devres::DevresLt,
     io::{
         Io,
         IoCapable,
@@ -14,7 +14,11 @@
         Mmio,
         MmioRaw, //
     },
-    prelude::*, //
+    prelude::*,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    }, //
 };
 use core::{
     marker::PhantomData,
@@ -151,6 +155,19 @@ pub struct Bar<'a, const SIZE: usize = 0> {
     num: i32,
 }
 
+impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
+    type Of<'a> = Bar<'a, SIZE>;
+}
+
+// SAFETY: `Bar<'a, SIZE>` is covariant over `'a`; it holds `&'a Device<Bound>`,
+// which is covariant.
+unsafe impl<const SIZE: usize> CovariantForLt for Bar<'static, SIZE> {}
+
+/// A device-managed PCI BAR mapping.
+///
+/// See [`Bar::into_devres`].
+pub type DevresBar<const SIZE: usize> = DevresLt<Bar<'static, SIZE>>;
+
 impl<'a, const SIZE: usize> Bar<'a, SIZE> {
     pub(super) fn new(
         pdev: &'a Device<device::Bound>,
@@ -223,15 +240,13 @@ fn release(&self) {
 
     /// Consume the `Bar` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<Bar<'static, SIZE>>` can outlive the original lifetime `'a`. Access
-    /// to the BAR is revoked when the device is unbound.
-    pub fn into_devres(self) -> Result<Devres<Bar<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the `Bar` does not
-        // actually outlive the device -- access is revoked and the resource is released when the
-        // device is unbound.
-        let bar: Bar<'static, SIZE> = unsafe { core::mem::transmute(self) };
-        let pdev = bar.pdev;
-        Devres::new(pdev.as_ref(), bar)
+    /// The returned [`DevresBar`] can outlive the original borrow and be stored in driver data.
+    /// Access to the BAR is revoked automatically when the device is unbound.
+    pub fn into_devres(self) -> Result<DevresBar<SIZE>> {
+        let pdev = self.pdev;
+        // SAFETY: `Bar` only holds a reference to the device and an I/O mapping, both of which
+        // remain valid for the device's full bound scope, not just for `'a`.
+        unsafe { DevresLt::new(pdev.as_ref(), self) }
     }
 }
 
-- 
2.54.0

