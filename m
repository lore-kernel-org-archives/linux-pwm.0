From: Shobhit Kumar <shobhit.kumar@intel.com>
Subject: [PATCH 4/8] drivers/mfd: Add PWM cell device for
	Crystalcove PMIC
Date: Wed, 29 Apr 2015 19:30:01 +0530
Message-ID: <1430316005-16480-5-git-send-email-shobhit.kumar@intel.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Povilas Staniulis <wdmonster@gmail.com>, David Airlie <airlied@linux.ie>, Shobhit Kumar <shobhit.kumar@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jani Nikula <jani.nikula@intel.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

TmVlZGVkIGZvciBQV00gY29udHJvbCBzdXVwb3J0ZWQgYnkgdGhlIFBNSUMKCkNDOiBTYW11ZWwg
T3J0aXogPHNhbWVvQGxpbnV4LmludGVsLmNvbT4KQ2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndh
bGxlaWpAbGluYXJvLm9yZz4KQ2M6IEFsZXhhbmRyZSBDb3VyYm90IDxnbnVyb3VAZ21haWwuY29t
PgpDYzogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4KU2lnbmVkLW9m
Zi1ieTogU2hvYmhpdCBLdW1hciA8c2hvYmhpdC5rdW1hckBpbnRlbC5jb20+Ci0tLQogZHJpdmVy
cy9tZmQvaW50ZWxfc29jX3BtaWNfY3JjLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2ludGVsX3NvY19wbWljX2NyYy5j
IGIvZHJpdmVycy9tZmQvaW50ZWxfc29jX3BtaWNfY3JjLmMKaW5kZXggNGNjMWIzMi4uODgzOWUy
NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZmQvaW50ZWxfc29jX3BtaWNfY3JjLmMKKysrIGIvZHJp
dmVycy9tZmQvaW50ZWxfc29jX3BtaWNfY3JjLmMKQEAgLTEwOSw2ICsxMDksOSBAQCBzdGF0aWMg
c3RydWN0IG1mZF9jZWxsIGNyeXN0YWxfY292ZV9kZXZbXSA9IHsKIAl7CiAJCS5uYW1lID0gImNy
eXN0YWxfY292ZV9wbWljIiwKIAl9LAorCXsKKwkJLm5hbWUgPSAiY3J5c3RhbF9jb3ZlX3B3bSIs
CisJfSwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyBjcnlzdGFsX2Nv
dmVfcmVnbWFwX2NvbmZpZyA9IHsKLS0gCjIuMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2ludGVsLWdmeAo=
