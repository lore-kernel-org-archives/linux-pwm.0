Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E12F39C7;
	Wed,  3 Jun 2026 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449060; cv=none; b=HPyPTeJL4EJWrXWC3MHYd/q9vDpMWJ2M0LUX7au/RtP6bmgXiD/DUpbIaZbRBN4H6T11QZuNQ5BhwKPj9RJqDhcFQRexPLRssZdf2GAK0cm6L9/qsK+ACWoYGz7f4XHJRiz2lYfAsXuPwOmIyjwK6n+ZXDWzW8zoqpUHTw6nUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449060; c=relaxed/simple;
	bh=TURasSuevhvFKc+WXuz6qvRLMMGZvPymK0qyzJQs2xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0Nn6Y57H0wvuW2WHJmg07T1O6A2A8ak1com1VFVzkuM09jkfFGjug90ydXix0/L3CiTS3aofvYSt3M44NESVXuZnAMe5Q2AmO0s+Gzvwb1djvUSsZV9dRSHo2McjL/u2bPD0ges9WFUlCkghAUXW4Tln+qgYH5q5wmnybKRbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE8/tXkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE8/tXkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F461F00893;
	Wed,  3 Jun 2026 01:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780449058;
	bh=jFXBZlmIt6khk0+6CdihUMf27NKcoYEyolnsYS/5aD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OE8/tXkLkk0Acfb00xG1OlNXaGaXQZrwIn73AQH+nMxR/sWrYHjxgfKRoUSBbR0Pm
	 kytHZDoalp1lv6hiDIrAaYkURdUxxaJV87/29f8ZjzV3SzCGbqkm8EV8XOSbGZbP7E
	 PF6MLp/KlL5dAIztupy1slPk32KRitQ/Wc4ONA71hqhaV6OaMBLOwfSr79N5we1gcA
	 7kx+jB+lZ00lscHda/Ax6Lt39X6nL7jJhCFpj83SIE837GtbM9k4WmyebH5nsIWpd0
	 Yw4a3SahsEZ/rnk0n31pPQ+T0oBzYyABkRk9I3bQmqdMPCiLOqUj2iT9oTizLnTGV6
	 0eQO4LS+xxy5Q==
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
Subject: [PATCH v2 6/7] rust: pci: return DevresLt from Bar::into_devres()
Date: Wed,  3 Jun 2026 03:10:17 +0200
Message-ID: <20260603011020.2073650-7-dakr@kernel.org>
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

Implement ForLt and CovariantForLt for Bar<'static, SIZE> so that
DevresLt can shorten the stored 'static lifetime back to the caller's
borrow lifetime.

CovariantForLt is sound because Bar<'a, SIZE> only holds &'a
Device<Bound>, which is covariant over 'a.

Since DevresLt::new() handles the lifetime transmutation internally,
into_devres() no longer needs an explicit transmute to Bar<'static>.

Add a DevresBar<SIZE> type alias for convenience.

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

