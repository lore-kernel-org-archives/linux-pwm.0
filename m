From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [v2 4/7] mfd: intel_soc_pmic_core: ADD PWM lookup
 table for CRC PMIC based PWM
Date: Mon, 22 Jun 2015 16:19:08 +0200
Message-ID: <20150622141908.GM25769@phenom.ffwll.local>
References: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com>
 <1434970465-12687-5-git-send-email-shobhit.kumar@intel.com>
 <5587EB7A.5090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <5587EB7A.5090402@gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Shobhit Kumar <shobhit.kumar@intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, bloften80@gmail.com, Povilas Staniulis <wdmonster@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Chih-Wei Huang <cwhuang@android-x86.org>
List-Id: linux-pwm@vger.kernel.org

T24gTW9uLCBKdW4gMjIsIDIwMTUgYXQgMDQ6MzM6MjJQTSArMDUzMCwgVmFya2EgQmhhZHJhbSB3
cm90ZToKPiBIaSBTaG9iaGl0IEt1bWFyLAo+IAo+IE9uIDA2LzIyLzIwMTUgMDQ6MjQgUE0sIFNo
b2JoaXQgS3VtYXIgd3JvdGU6Cj4gCj4gPk9uIHNvbWUgQllUIFBMYXRmb3JtIHRoZSBQV00gaXMg
Y29udHJvbGxlZCB1c2luZyBDUkMgUE1JQy4gQWRkIGEgbG9va3VwCj4gPmVudHJ5IGZvciB0aGUg
c2FtZSB0byBiZSB1c2VkIGJ5IHRoZSBjb25zdW1lciAoSW50ZWwgR0ZYKQo+ID4KPiA+djI6IFJl
bW92ZSB0aGUgbG9va3VwIHRhYmxlIG9uIGRyaXZlciB1bmxvYWQgKFRoaWVycnkpCj4gPgo+ID52
MzogQ29ycmVjdCB0aGUgc3ViamVjdCBsaW5lIChMZWUgam9uZXMpCj4gCj4gVGhpcyBwYXJ0IHNo
b3VsZCBvbmx5IGRlc2NyaWJlIHdoYXQgdGhpcyBpcyBhYm91dC4uCj4gCj4gRG9uJ3QgcHV0IHRo
aXMgcGF0Y2ggY2hhbmdlIGhpc3Rvcnkgb3ZlciBoZXJlLgo+IEluY2x1ZGUgdGhpcyBjaGFuZ2Ug
aGlzdG9yeSBhZnRlcgo+IC4uLgo+IFNpZ25lZC1vZmYtYnk6IEF1dGhvciA8ZW1haWw+Cj4gLS0t
Cj4gCj4gPkNDOiBTYW11ZWwgT3J0aXogPHNhbWVvQGxpbnV4LmludGVsLmNvbT4KPiA+Q2M6IExp
bnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4KPiA+Q2M6IEFsZXhhbmRyZSBD
b3VyYm90IDxnbnVyb3VAZ21haWwuY29tPgo+ID5DYzogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbT4KPiA+QWNrZWQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+Cj4gPlNpZ25lZC1vZmYtYnk6IFNob2JoaXQgS3VtYXIgPHNob2JoaXQua3VtYXJAaW50
ZWwuY29tPgo+ID4tLS0KPiAKPiBIZXJlIHlvdSBhZGQgdGhpcyBjaGFuZ2UgaGlzdG9yeSBzbyB0
aGF0IGFmdGVyIGFwcGx5aW5nIHRoaXMKPiB3aWxsIG5vdCBiZSB0aGUgcGFydCBvZiB5b3VyIGNv
bW1pdCBkZXNjcmlwdGlvbi4KPiAKPiBUaGlzIGNvbW1lbnQgaXMgYXBwbGljYWJsZSBmb3IgYWxs
IG9mIHlvdXIgcGF0Y2hlcy4KCkl0J3MgaG9uZXN0bHkgYSBwZXItbWFpbnRhaW5lciB0aGluZyBh
bmQgaGFyZCB0byB0ZWxsIHdobyB3YW50cyB3aGF0IC4uLgpQZXJzb25hbGx5IEkgZG8gd2FudCB0
byBpbmNsdWRlIHRoZSBwYXRjaCBjaGFuZ2Vsb2cgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgotRGFu
aWVsCj4gCj4gCj4gLS0gCj4gQmVzdCByZWdhcmRzLAo+IFZhcmthIEJoYWRyYW0uCj4gCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBJbnRlbC1nZngg
bWFpbGluZyBsaXN0Cj4gSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHA6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngKCi0tIApEYW5p
ZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxv
Zy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
