From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/3] acpi_lpss/pwm: Fix i915 pwm_get issues
Date: Sun, 22 Jan 2017 17:14:06 +0100
Message-ID: <20170122161409.21601-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pwm@vger.kernel.org

SGkgQWxsLAoKSGVyZSBpcyBhbm90aGVyIGF0dGVtcHQgYXQgZml4aW5nIGk5MTUgbm90IGZpbmRp
bmcgdGhlIGxwc3NfcHdtCmRldmljZSAoZml4ZWQgYnkgY2FsbGluZyBwd21fdGFibGVfYWRkIGZy
b20gYXBjaV9scHNzLmMpIGFzIHdlbGwKYXMgaTkxNSBub3QgYmVpbmcgY2FwYWJsZSBvZiBwd21f
Z2V0IHJldHVybmluZyAtRVBST0JFX0RFRkVSLgoKSSBtdXN0IHNhdCBJIHJhdGhlciBsaWtlIHRo
aXMgdmVyc2lvbiAodnMgZm9yY2luZyBwd20tbHBzcyogdG8gYmUKYnVpbHRpbiksIHNvIEkgaG9w
ZSB3ZSBjYW4gbW92ZSBmb3J3YXJkIHRvIHRoaXMuCgpBcyB0aGUgYWNwaS9scHNzIGNoYW5nZXMg
KHBhdGNoIDMvMykgbm93IHJlbHkgb24gc29tZSBjb3JlIHB3bQpjaGFuZ2VzICh0aGUgZmlyc3Qg
MiBwYXRjaGVzKSBJIHN1Z2dlc3Qgc2ltcGx5IG1lcmdpbmcgYWxsIDMgcGF0Y2hlcwp0aHJvdWdo
IHRoZSBwd20gdHJlZS4gUmFmYWVsIGlmIHRoYXQgaXMgb2sgd2l0aCB5b3UsIGNhbiB3ZSBoYXZl
CnlvdXIgQWNrZWQtYnkgcGxlYXNlID8KClJlZ2FyZHMsCgpIYW5zCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50
ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
